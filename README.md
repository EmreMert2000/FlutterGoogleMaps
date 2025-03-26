# ✨ FLUTTER MAP APP ✨

 **MVVM + Provider** altyapısını kullanarak harita üzerinde konum yönetimi!

 ## 🚀 ÖZET
Bu projede, **MVVM (Model-View-ViewModel)** tasarım deseni ile **Provider** paketinin gücünden faydalanarak, harita üzerinde konum bilgilerini yönetiyoruz.
Kullanıcılar ekrana dokunarak yeni işaretçiler ekleyebilir, mevcut işaretçileri silebilir ve konum bilgilerini görüntüleyebilir.

**Model (location_model.dart)**  
   - Konum verilerini (enlem, boylam, başlık, açıklama) tutar.  
   - `LatLng`’e dönüştüren bir **getter** metodu vardır.

2. **ViewModel (map_view_model.dart)**  
   - **ChangeNotifier**’dan türeyerek durum yönetimi yapar.  
   - Harita işaretçileri (markers), konum güncellemeleri ve iş mantığı buradadır.  
   - View’daki değişiklik isteklerini karşılar ve dinleyicilere (listeners) bildirim yapar.

3. **View (map_view.dart)**  
   - Kullanıcı ara yüzünü (UI) içerir.  
   - **ViewModel**’den gelen verileri ekranda gösterir, kullanıcı etkileşimlerini (tıklama vb.) **ViewModel**’e iletir.

4. **Main (main.dart)**  
   - **Provider** aracılığıyla **ViewModel**’i uygulamaya enjekte eder.  
   - Uygulamanın ana giriş noktasıdır (`MaterialApp`, tema vb. ayarları içerir).

Bu düzenleme ile:  
- Kod daha modüler, düzenli ve bakımı kolay hale gelir.  
- Sorumluluklar net biçimde ayrılır.  
- Test edilebilirlik artar.  
- Kod tekrarı en aza indirilir.

---

## 🎉 ÖZELLİKLER
- **Konum Yönetimi:** Harita üzerinde tıklanan yeri otomatik olarak işaretler.  
- **Marker Ekleme/Silme:** Yeni konum ekleme veya var olanı silme fonksiyonları.  
- **Dinamik Güncelleme:** Kullanıcı etkileşimleri anında haritaya yansır.  
- **Basit, Hızlı ve Etkili:** Minimal arayüz, düşük karmaşıklık.

---

