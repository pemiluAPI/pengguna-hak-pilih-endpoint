class HakPilih < ActiveRecord::Base
	CATEGORY = {category: [{nama: "Pengguna Hak Pilih"}, {nama: "Tidak Menggunakan Hak Pilih"}]}

	validates :nama,
            presence: true

  scope :by_id, lambda{ |id| where("id = ?", id) unless id.nil? }
  scope :by_category, lambda{ |category| where("category = ?", category) unless category.nil? }
  scope :by_nama, lambda{ |nama| where("nama like ?", "%#{nama}%") unless nama.nil? }

  def self.apiall(data = {})
    hak_pilih          = self.by_id(data[:id]).by_category(data[:category]).by_nama(data[:nama])
    paginate_hak_pilih = hak_pilih.limit(setlimit(data[:limit])).offset(data[:offset])

    return {
      hak_pilih: paginate_hak_pilih.map{|value| value.construct},
      count: paginate_hak_pilih.count,
      total: hak_pilih.count
		}
  end

  def construct
    return {
      id: id,
      nama: nama,
      category: category,
      jumlah: jumlah
    }
  end

protected
  def self.setlimit(limit)
    limit = (limit.to_i == 0 || limit.empty?) ? 1000 : limit
  end

end
