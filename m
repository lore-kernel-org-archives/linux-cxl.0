Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144612E7635
	for <linux-cxl@vger.kernel.org>; Fri,  8 May 2026 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210276; cv=none; b=ka++Qov4/1HXSbsD8jAqjrHiG3qxnQtjtVZsAfimN1V5fK8chK7NDVWSBrhFUtkWkoCYlRIs/MunRAE8iVKNoReBKppjVpY+v8YIZgJXc4e0SFrFc3pgKLsKoSNMEkQgDuVgJPz+Uo9pcvuT+WSh9V4hgfoZod/9s3KSXq6BNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210276; c=relaxed/simple;
	bh=ywX2QQkJINgcF5rI6352/2UoVw6y6LLcc5xcEUpnPLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G2MtNrnDwoKc2v5GLB8NDAxPUrR1rYrP4bunM4DThOD0/O0FdZbWs9OS8YCvt+FSvXwh5F5+w8ifN8QDgNGRp9pUCYaa2FbjD7CDJIQFDJSFggkLycSF/SMhTD6xcWu02RQjgHouTpQCOzlxPOChVzzwK6b4HL3eBatFRphe/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rP/T5/ml; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rP/T5/ml"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba6485d219so10110525ad.3
        for <linux-cxl@vger.kernel.org>; Thu, 07 May 2026 20:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210274; x=1778815074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pamfLAjX62QtHOtvvGRA+RHxyD1vV0e3dMD4KWIMlE=;
        b=rP/T5/mlsDra0O6cXplImVIOLvzvSFBrU/Tg956etLmgh58OVygXbxhIMeZEd7m7hl
         8QAm8Gxb52TYfDryfGb+TOiAAwzLMgkLzBLL7X31CT8FMBDMmYQWKoiUM1Ra7YfI+NKd
         nESs345e5jrX/pARwvR42hKCto4cni2xVT1ouIzN4ghNnfph7z/WY0C0Jm8D+qC46uM/
         Ny9nwVQ398h5J9ohs50/4p/0vBcQeI5M4+RGuvktn7FrjGlWJuMO5nuKG5iQL68LyX5/
         VQMZjovMl/MVGwBFfYmigw7gXVP2e0ore1aX2wks27WrCHbwYbb25wqbzrz3YlsUclmS
         H9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210274; x=1778815074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0pamfLAjX62QtHOtvvGRA+RHxyD1vV0e3dMD4KWIMlE=;
        b=G9KA25Sbje3L8ql+eV1wU5pQLir79EECrtbfbbUsqGBrIKtg3qTODd3Ww1knBGRgun
         8qVjpUr8k9rltQBo7pZGcRXWoPIMFpgO6DTHe+fprwupmVkytBE95VXTnnJRRTzZOioq
         lXs9SLLXAkUNVcwT6fn0zQYHXWpuVuCaWJzK/ChGEOspwC5l/V1LbTxaBT2mvWfus3mX
         lozG/f/L92tO0BTOt+6TwVJE8Wwr3EX1eVQDh1XGyGeG9dtSPe+mGAaPTxdAThgdyKN1
         pXMOTa+3TJsJ+6vI5h70ZTatIaUvmak+wJvZXLEWT8hbaTfOJO9y7njwlMqZp8XXaYAu
         Xfsg==
X-Forwarded-Encrypted: i=1; AFNElJ/ytCxv/vYnngKXXT5QYmegW2qUCa83EbKguiZmqIEdcq61gGzQ6oiTILaQueaxJK4+Ohphhx8exCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJdGoZ62FFZoI7fYEGBWepklYcRz/qBquo+loBLZUAO+0+HoS
	ZFcLcLda+GvCEBNayxHYfSRyv6DZ3+rRXj6IJuxcSW1mx5hqIsxw37vo
X-Gm-Gg: Acq92OEdjNLgOEkOtnjNvwBib9CBTST0M59UV5OQW21IMWmE57hnLGnhVPFjd0WueD/
	kADVs3CmlfLu7uZXCNTd7+K2/fOyBCl6P56GszIWA0JPrMEvV1/Q+6iaOer67llswuev2+pa+i+
	eRAh40cJ92y9VJFkvmHgmp4mC9nmkHjY6JVNem5DA9fg2x2VDS+deyRzVFeAj2nyp4frCZ8Jhb7
	eti5WKrnZdVWEc8b/XR6BLWWJ0qUnjh4MvRxqmtpLtv69oaWsHJWGQ9ZTi9hkM8eMuAn5nOBUV8
	d+ac72IBzg3/fvMR3zneO87YtwPfZvE8v+aKBuFE/VXeaSCuBNdremVtq9mB/+X+cJxdLbg+IjV
	RQabcnw/lxXi1pc4c5fgkntyHEuYMqg/ZZd3T0rYRYVX6/z/IVdRjspLwRGRihUix8UDEzcEizZ
	G62PNX4VZOgWaXOEVY9zYsqC656aXQETUcU4GyOirR
X-Received: by 2002:a17:903:90e:b0:2b0:b016:773f with SMTP id d9443c01a7336-2ba7908443cmr108576085ad.11.1778210274288;
        Thu, 07 May 2026 20:17:54 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:17:53 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 04/18] X.509: Move certificate length retrieval into new helper
Date: Fri,  8 May 2026 13:16:56 +1000
Message-ID: <20260508031710.514574-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

The upcoming in-kernel SPDM library (Security Protocol and Data Model,
https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
ASN.1 DER-encoded X.509 certificates.

Such code already exists in x509_load_certificate_list(), so move it
into a new helper for reuse by SPDM.

Export the helper so that SPDM can be tristate.  (Some upcoming users of
the SPDM libray may be modular, such as SCSI and ATA.)

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 crypto/asymmetric_keys/x509_loader.c | 38 +++++++++++++++++++---------
 include/keys/asymmetric-type.h       |  2 ++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_loader.c b/crypto/asymmetric_keys/x509_loader.c
index a41741326998..25ff027fad1d 100644
--- a/crypto/asymmetric_keys/x509_loader.c
+++ b/crypto/asymmetric_keys/x509_loader.c
@@ -4,28 +4,42 @@
 #include <linux/key.h>
 #include <keys/asymmetric-type.h>
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen)
+{
+	ssize_t plen;
+
+	/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
+	 * than 256 bytes in size.
+	 */
+	if (buflen < 4)
+		return -EINVAL;
+
+	if (p[0] != 0x30 &&
+	    p[1] != 0x82)
+		return -EINVAL;
+
+	plen = (p[2] << 8) | p[3];
+	plen += 4;
+	if (plen > buflen)
+		return -EINVAL;
+
+	return plen;
+}
+EXPORT_SYMBOL_GPL(x509_get_certificate_length);
+
 int x509_load_certificate_list(const u8 cert_list[],
 			       const unsigned long list_size,
 			       const struct key *keyring)
 {
 	key_ref_t key;
 	const u8 *p, *end;
-	size_t plen;
+	ssize_t plen;
 
 	p = cert_list;
 	end = p + list_size;
 	while (p < end) {
-		/* Each cert begins with an ASN.1 SEQUENCE tag and must be more
-		 * than 256 bytes in size.
-		 */
-		if (end - p < 4)
-			goto dodgy_cert;
-		if (p[0] != 0x30 &&
-		    p[1] != 0x82)
-			goto dodgy_cert;
-		plen = (p[2] << 8) | p[3];
-		plen += 4;
-		if (plen > end - p)
+		plen = x509_get_certificate_length(p, end - p);
+		if (plen < 0)
 			goto dodgy_cert;
 
 		key = key_create_or_update(make_key_ref(keyring, 1),
diff --git a/include/keys/asymmetric-type.h b/include/keys/asymmetric-type.h
index 1b91c8f98688..301efa952e26 100644
--- a/include/keys/asymmetric-type.h
+++ b/include/keys/asymmetric-type.h
@@ -84,6 +84,8 @@ extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 
+ssize_t x509_get_certificate_length(const u8 *p, unsigned long buflen);
+
 int x509_load_certificate_list(const u8 cert_list[], const unsigned long list_size,
 			       const struct key *keyring);
 
-- 
2.52.0

