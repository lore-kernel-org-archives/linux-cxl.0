Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177B379999
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427039; cv=none; b=oJ4AgSTh50NpqyYSJewJumLqzLeH/rh+vV34oJRYYnTI1Mqtt7sPvKBscLEHYig3sIYs9ajA9/Q1K5yNBHx6cQB++imzx7Jzv90ZO1H/cOmqHnOeJu2n5OkfseBCwfqKeV5OdDpQ2RTnqN17sgFtkqDJbY8Awj81ahTC06mookw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427039; c=relaxed/simple;
	bh=6IXyikUrXXga0w+XTOVh8PGo9rM6Mf6O+h0Sd4yHab4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CK/ZgE7OoRLoYuubd2DnLkdgcFQo5OatouDKQ8X5LcAu96cSY7ijB18L4XzSkONp3XvGvZAuIcHaSvqkiyF705ZXisu2rfYIJhf+pTXsgYLz9avB4H/1UAwzu8slLqcVwk6NbxkG8qbsqGWCQsNN3YG+xNG1WbMpstVnGdQ5+gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwAksuye; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwAksuye"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45a81568eafso116116b6e.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 13:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768427023; x=1769031823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KokXwqCF3cjj7h8MwPrV07VxZRdfFYCa5Cm5tvCoTf0=;
        b=DwAksuyem4fEXByAYX/OKg/0P0/Ha1dtdmlvYZE+UKXX7YyZhN6fgvtGrdB1rdORUR
         JYGbLkRMbFZiHz2y/aRbCY+WLcRwNL7CXT0eUHAYgo6HV+q8lpX1KviYMFS/BE7mNHGk
         uyH986y0xx/kzFtWryKbAN9a5V1E+Jl3Mm7y5ym+XXz5kbjSeR2t3iwG40PFZZElLFHn
         26IlsFBc5TWc/7ZiOL422nsR/U8knSTp40kFKtyt2oAWo9N5sNTgSgPA/2ieckJvpcJD
         yQ70eaExuqB3Xs/c0UplQHbP9DgRJGwkfpx2CiMo0vveGX7b6miuFZlcKRl1iwukA1KD
         ZCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768427023; x=1769031823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KokXwqCF3cjj7h8MwPrV07VxZRdfFYCa5Cm5tvCoTf0=;
        b=An0tAarNLC5GKCssgQlN5uba3U0voiIaUOTXzXUoYB+99LnXV43fRRG+ymifc9CNea
         zZfuMZmrtKn9kX9Y85wroKdN/Mprv+D++TH7S7q3UoRKz85dSPCWwVBS5wxSfM74qQz6
         Uo7gxZ/3SAhoASG2xxXyGvuBbWYaMEiKHhw6BUuogAXs4tcYq0shECkTJ4Lc3q9pjaYU
         co5KqHL21vkJIqqrbBPWOUa9PVgKBMJ+uxUGEA31LPNmg57Rka/cbYYBWuYve/jU6bHp
         aHL6SqJ0xTo61bavobcu+U9MTqQ6fnJZFmxyLigSOjVlQhuEtlP+1+Bt25/bUh1xOCaG
         d8Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU6lGMXsU/IBc/N47NIWkCnHgwvkJ57OxhkazGctse4FJiWChHGKbL10TZ1QMBpOq/5GG5Z9FDyP2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oYGafp7/xbrgwQ8mNCKzF/+JO3O8V549ehVWlejnLiSVIqjW
	mgl/dy2WRSyI+icDlB89bBtmgA2xK6iS8osioByKdBcnX4kpWiHP3ynY
X-Gm-Gg: AY/fxX7vATGZcztkuz2mxvAQ7wmTkIL7at4VdAj28OK1d735JMUGyS5RgM/69An+gZS
	BADPSRhXUtOwZzDKvRhpHBu46mllW/5nnYhb12V3rWKXw6wbd7QZZjDxSpoDQNZIsKqfKpp0toy
	3Ol2Jy2BO0gXuzN68X86fm1bJmJ8nItWf7Ty6BakmvHW6fO+H2pHGXQTqZ+52z37y2IRbrqedjM
	EL6qPGRPUpXvhDluO0z8xA4AVsh2/IrAocPvKn+VfSf6kjcZ3lHIflBEhDlBw8UkpqKxP5Phvcf
	RFTb+u2A9agcgT/vQyIxiXSQRESjIqLSCrCYGpWCHukOfUmn6fPPWrzNS1kFlExPqNftXazhy2v
	VezAuZWnFmAoXTyNQrDQUxd5fVVvOTHK7C+geav9+sNY3VvIQEa07+FxD62oAZFx6LZfXf9yV4N
	e1bVNtHca7i8Ydzz/6m3FxiaiGB0q6u26Q1BqRhWKawNDl
X-Received: by 2002:a05:6808:229f:b0:450:ad22:f9ee with SMTP id 5614622812f47-45c712da165mr2717268b6e.10.1768427023109;
        Wed, 14 Jan 2026 13:43:43 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa515f4dasm17619569fac.21.2026.01.14.13.43.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:43:42 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH V4 1/3] fuse_kernel.h: bring up to baseline 6.19
Date: Wed, 14 Jan 2026 15:43:05 -0600
Message-ID: <20260114214307.29893-2-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114214307.29893-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114214307.29893-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is copied from include/uapi/linux/fuse.h in 6.19 with no changes.

Signed-off-by: John Groves <john@groves.net>
---
 include/fuse_kernel.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 94621f6..c13e1f9 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -239,6 +239,7 @@
  *  7.45
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
+ *  - add FUSE_NOTIFY_PRUNE
  */
 
 #ifndef _LINUX_FUSE_H
@@ -680,7 +681,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_DELETE = 6,
 	FUSE_NOTIFY_RESEND = 7,
 	FUSE_NOTIFY_INC_EPOCH = 8,
-	FUSE_NOTIFY_CODE_MAX,
+	FUSE_NOTIFY_PRUNE = 9,
 };
 
 /* The read buffer is required to be at least 8k, but may be much larger */
@@ -1119,6 +1120,12 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+struct fuse_notify_prune_out {
+	uint32_t	count;
+	uint32_t	padding;
+	uint64_t	spare;
+};
+
 struct fuse_backing_map {
 	int32_t		fd;
 	uint32_t	flags;
@@ -1131,6 +1138,7 @@ struct fuse_backing_map {
 #define FUSE_DEV_IOC_BACKING_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 1, \
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
+#define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.52.0

