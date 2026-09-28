Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29515341057
	for <linux-cxl@vger.kernel.org>; Mon, 28 Sep 2026 01:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790557946; cv=none; b=cfQy09sR1pR/7+k4ObRnafXvbhB/CA9hjKYd32wFvwzUPsGD+i8aOJ59d1kCb73BCwloA37B46Kgz9+WaUYR9D4zfNKFwR7Bl3ecBKJ2zZ2xLhAS18479yV5f2LmehV4krgYPc85hXJISf5erHt0OoeamCx6eS8gijHDcaCvJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790557946; c=relaxed/simple;
	bh=ka5L0T+crJoJEiz3RZq9V1G0Q0j+3Njce27Rj8beaoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoTacEqUgln1LNLHIWf6oF8CioqnhmWlfnUF+vDcugSKGdJ7ORR2z1vJ31LFOTQMDoJtfS+HKR/lUs3bokLIsjlqxljD/v14w263/MY99H76VXIb1cpJhTYVaQaITJqFQJmmX/GfDgFBb0K4IuIzcMZtQRx80kG6+tJQ4IoFWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNommUsr; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNommUsr"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so997461a12.0
        for <linux-cxl@vger.kernel.org>; Sun, 27 Sep 2026 18:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790557944; x=1791162744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xGgjKe37C8O7WXzR8vYD3Gt2KMUFwTc1B/YEqcfdSWU=;
        b=gNommUsrjxTH8d0z06ys1uhlm9hHoVdmO54W1aQZ+dlYyyECev0UofiJb3DLV5d2f2
         /tvNFkrDNOcSMfCtR0MUCoyjB/oTxdD/zwDWU1sGmMT9j498PVL1aDKnVnvx0cE7YwDY
         BfW9KBKCZep8o1X1LubQVyJizVfUFpWKL99dSsmbRBAZefBjEpWllrLzwY0yFuIKTZrX
         IgNU/985fEDfEIlY8cqNATRwH4vI8sJU977Aod6PIwsh1eoamyZa7h/3F4uCZL6Rd6xk
         AepArh2FQHaOV/4OPU+NjQ72Nfy6al+g4FBoitzAUFsavhaOCH2h7tKfQRcDpL3L4MRo
         lwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790557944; x=1791162744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xGgjKe37C8O7WXzR8vYD3Gt2KMUFwTc1B/YEqcfdSWU=;
        b=js5SOcry0ji6G83TJCTNuZ8YSqsCmJmfWFqGlS2xkQkEkypTO9bRzOploClD6L+D9n
         hNipjt9JW/YXuH/wvDPp8eOq2fVQ6w7XuQJGFsMqAKoCmtiFv/qtYyInXhTD3o00nGJX
         rsIf0ggwQX1JecDvmEps8RtFAMykspjdZHwVI3O9pE4bd3UytSAzfJRh5RdbhGVr+h3D
         MkoC0Pkm6vQUbWiz7rW7dWiyeHVKefwIxeUNFLDJne231QnfL+sGX4H6E4ocVrJoaZ9n
         s4KZU3g5rdQ1XxUFzPhp6Z6eZ1s6zKZrfYnf+mr3/rfzpwXd4R310eDMKXGTbdF8i/3M
         tM9A==
X-Forwarded-Encrypted: i=1; AKwUvBxNikUM6nMG3BPiOpH8TlVsjePyWtMHVb89VspzdSLzw+nlZNVNEJyKpW1+7YsiLt6H6elo3wdKOWk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9KOiQohgtWxRjrYLl+Kf2kseTI5wU4VHR+zX32XWl1/MhlqDr
	7d2Zr1nrcA9uO01xzdxHsAU3e9VXCn5dOilL1GJnZ2qck0P+04dyAYOx
X-Gm-Gg: AYBFou0NrQska2LPpYb84asidQez2jys3ZgbHdBmPkwBZwNOguJ9QEM9pwlOdW961oE
	BBOcQ7FyY/w0HnMwlLICHe8Sq6kKptFZFfjfUuFWmdmpdXkUWHEKSJa2e/t1ed3l9ZrhjRo110n
	BLloOMFvqwNnH32jofLiYarLqEj9RFyuvBMpNC8Yt5utdq6ePAzjlYJXJAuAwZZmZ2IOTUEaVxV
	9zGi5Z2jegHZQPUn86ATVIigatz4bd4Jpc98fLzdxhuLftGcH1SpRLR6x0C7WR6DwdUg6Ck/PSH
	i7i8H0RQ8Ag3uA1MgbY6BlhZ71PN32MUpswd2dPoqUyxzzUu3o2MPfgtru17s+dbVhX9ZXqPp3w
	+2Kp8s/QPmDn4T4k21HuhS8ztpy1MudxLJjpwligU3jBB5KWGN2L+37tkDMqJvCRW/LZitSi5Rk
	0JTmSlcWPz6uUiAv8yHbpEFV4Cqf+mqMq9QReF9dF9FmUzekXksQFcYEGvUyVsQBCdO05KuXrUB
	juf06MsRQ4F/Zn4
X-Received: by 2002:a17:90b:4c82:b0:39e:6c68:1552 with SMTP id 98e67ed59e1d1-3a09896ee0fmr8267708a91.26.1790557944459;
        Sun, 27 Sep 2026 18:12:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e7036e3bsm10425773a91.13.2026.09.27.18.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 18:12:23 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: lukas@wunner.de,
	linux-cxl@vger.kernel.org,
	akpm@linux-foundation.org,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	bhelgaas@google.com,
	alistair@alistair23.me,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: wilfred.mallawa@wdc.com,
	a.hindborg@kernel.org,
	gregkh@linuxfoundation.org,
	alex.gaynor@gmail.com,
	alistair23@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	gary@garyguo.net,
	ojeda@kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 07/22] X.509: Move certificate length retrieval into new helper
Date: Mon, 28 Sep 2026 11:11:08 +1000
Message-ID: <20260928011123.450800-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928011123.450800-1-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
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
index 0d516c77cc26..174451b93eda 100644
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
+	if (p[0] != 0x30 ||
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
-		if (p[0] != 0x30 ||
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
2.55.0

