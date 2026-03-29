<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
</p>

# 🌟 My Visionary

⚠️ **Work in Progress – The app is currently under development.**  
Bu proje hala aktif olarak yazılmakta ve geliştirilmekte olan bir mobil uygulamadır. Google Play’e yüklenmeden önce özellikler tamamlanacaktır.

**A Flutter-based productivity app for tracking daily tasks and long-term goals.**  

---

## 🎯 Proje Amacı
My Visionary, kullanıcıların hem **günlük sorumluluklarını** hem de **uzun vadeli hedeflerini** tek bir platform üzerinden planlayıp takip edebilmelerini sağlayan mobil üretkenlik uygulamasıdır.  
Uygulama, hedef belirleme, görev yönetimi ve odaklanma sürelerini birleştirerek kullanıcıların disiplinli ve motive bir şekilde ilerlemesini destekler.

---

## 🚀 Temel Özellikler / Features

### 👤 Kullanıcı Girişi
- Email & Password ile kayıt olma  
- Google ile giriş yapma  
- Oturumun açık kalması  

### 📊 Dashboard Sistemi
- Birden fazla dashboard oluşturabilme  
- Dashboard’lar hedef/yaşam alanlarını temsil eder (örn: “Fitness 2026”)  
- Dashboard silme ve özelleştirme  
- **Freemium Model:**
  - Ücretsiz kullanıcı → maksimum 2 dashboard (ek dashboard için ödüllü reklam)  
  - Premium kullanıcı → sınırsız dashboard  

### 📝 Daily Task Modülü
- Dashboard’a özel görev ekleme, tamamlama, silme  
- Basit ilerleme takibi  

### ⏱️ Pomodoro (Focus) Modülü
- 25 dakikalık odak süresi  
- Geri sayım sayacı  
- Seans tamamlandığında bildirim  
- Tamamlanan seans sayısının kaydı  

### 💰 Monetizasyon
- Freemium yapı  
- Google AdMob Rewarded Ads (ödüllü reklamlar)  
- Premium sürüm ile reklamsız kullanım, sınırsız dashboard ve gelişmiş istatistikler  

---

## 🛠️ Tech Stack / Teknolojiler

| Katman | Teknoloji |
|--------|-----------|
| Mobil | Flutter & Dart |
| Platform | Android (iOS ilerleyen aşamada) |
| Backend | Firebase Authentication, Cloud Firestore |
| Monetizasyon | Google AdMob (Rewarded Ads) |

---

## 🏗️ Uygulama Mimarisi (Genel)

```text
Login / Register
        ↓
Authentication (Firebase)
        ↓
Ana Sayfa (Dashboard Listesi)
        ↓
Dashboard Detay
   ↓        ↓
Daily Tasks   Pomodoro
