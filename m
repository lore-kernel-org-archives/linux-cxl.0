Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B226344042
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770780617; cv=none; b=lqt5lPy1kpdYFHQuW7DlhB3Fc2lvK2HLy2kXvmq5ePCE585XR9Y2pB/ICOGAx7os1lp8cmBcFAP6VAhx82hj8lDSgMU19syLCY8lYPiJ/gKbZiKHS7w/ghQxju5sQOF9WzSySH9kXDnxppjz5uKIWcL83BmIzSxgCAcYueLMKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770780617; c=relaxed/simple;
	bh=ywX2QQkJINgcF5rI6352/2UoVw6y6LLcc5xcEUpnPLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rl+a3D+IR52IsrxRZsk3+3oQB8hBqbCvzroLk5DJOomQbkFPhZgbJsZDXrk7lIPuqe8g/LEX8uB4J0zkLeZ8CArl6U+lUm/KljczaTJcd4uci9zIqNFGLB6xK1ynzeKHpucTwuzn4uc/tb1TJRFJjxJLvpXcpjrah1a6GWgDJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgBBR4jU; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgBBR4jU"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6788f3db37so573781a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 19:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770780615; x=1771385415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pamfLAjX62QtHOtvvGRA+RHxyD1vV0e3dMD4KWIMlE=;
        b=lgBBR4jUmLdS/ZJqcJEbs3xwcm2d3xrOv86huUcb+L6/yMG7cKGeV6PIfLNEUbYnay
         piwLgQCJuVyexOn0lJS2+ZLbFIYEViTN1sYiIg0DbQJoJbzm+bnw6itwtTFK6tZj9FJB
         NCebZvynBcnZ3RSrh1xBJrUAWqaPuNGZCeOZOjiceiYv6aVm7B7iMuT1KGmOXnQsysUc
         UHooQ841IS2IqLBAGIy+wBYMl5I+HrRuDLF7uy0pPhjbqxMx8oGjwtUtwGjW2TQTIu7P
         ywGKm87Q1eI3IbkWj6SkQtKFtqzP2eUrdU9Z4IEf9bCzAeiMaeBFDTPRG8X1eOBNnhPp
         fkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770780615; x=1771385415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0pamfLAjX62QtHOtvvGRA+RHxyD1vV0e3dMD4KWIMlE=;
        b=uMzBnv8JqBP4JJCCHj2CP4eqkR1ljduql9vjHHLWrVwSfCCZYxktoKV4gRDXggL5Jg
         NmbM6QI+H3R/kyXQ/r2kbxWQSYlV1CtrateqUajvXhvF+5CsuPwc7laVuBL6w0xzACKF
         c0gzBZ73XjmBoOlk4io58rZH3gtjBV+/l/+4Cb8fXsPk5vESliMB5jIPR5vX1lzWv3Mg
         NxLt4J7jXR0FWoGNo2iTSPpSbVrRSdE96Log3L61L9A4nAAYKPLxM17577l2WsA+nH0T
         8VVzCddi17rwPsNLL2QKe2bhxNrKUA2EwJdd0wvSUtVuQgkvqjhucBrrVhqUHG2Rzrsq
         YmEg==
X-Forwarded-Encrypted: i=1; AJvYcCVD+khIF+L4diq7XTuPkotRbJzxkEKFEOau4oyrS/6DG9JMoNcE5yiBS8BeBMq3Imy+4m6q7RmQ6uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2hkGTvgNEhJ5gcl37flELp+mQ9ITy4qUN1O+unYrf8c/6kmO
	AnOyIgBI+29zw8rzBWgyK/cUiwH3oBi1cXMpituMSGWJF9PJqi/N8LAZ
X-Gm-Gg: AZuq6aLd7tQacLpitZ2jTwCC1L1rXqK7cNqia4FB7lbE/dHX7x0YHIJAn66mOxX5noZ
	gxFZNM+pW5GKtNu/CX5AOHews3Mnw0IbYY59Z8fJ5NrUnCgYtuLWf4nNDSa1iegN+VBJbU21r7r
	WBFyIp2230NjozYvekcp/5lF/oSve0wrD60n/1cXcHcVTr9nZ9oG8Sjdn7YX/yEUgJIIqydNMDW
	vwu5C63CeJ5xqBkXMIBrlMZM7vWFMN9MBK72FBGFKDynSDCLjAUk7HRj2VB85hT2SgUZq/RDQ4Z
	pMcaOyKlJg9JAnt5l399vgdCaakcfgEXdArQ/Q6H/SKAualO3ynKT3/Na4OIr5tnH54QuS5r6bi
	QhiL/P3j+9ey3eAPaBYVEVac03n4m4Xf0MtEmere090UOJE2JB2EqAeph21n3m9+93SfEdXlN9P
	YYpC9yvtPnWTvZGJ7D0/c9rfmaISx0SRhakf0ykOiliw==
X-Received: by 2002:a05:6a21:6016:b0:366:14af:9bd8 with SMTP id adf61e73a8af0-393ad3ec860mr17499551637.78.1770780615453;
        Tue, 10 Feb 2026 19:30:15 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e197d63c9sm464856a12.20.2026.02.10.19.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 19:30:15 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: bhelgaas@google.com,
	lukas@wunner.de,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	alistair23@gmail.com,
	ojeda@kernel.org,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v3 04/27] X.509: Move certificate length retrieval into new helper
Date: Wed, 11 Feb 2026 13:29:11 +1000
Message-ID: <20260211032935.2705841-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260211032935.2705841-1-alistair.francis@wdc.com>
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
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

