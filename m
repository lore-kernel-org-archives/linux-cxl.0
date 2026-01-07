Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BB7398705
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800099; cv=none; b=kXYRD//WeXXG0fzjQ4991QZhUAcPjOAmWAgxWxgXbmsOfc1trfTWdq2pjQRAdfitixvi0h741roQHKRW9fvMQQe8AwJDMceK4M8zpe1ZZTrPaQv6MsRZOrHQVKWnkH58Pi83N2zNThOCdYyQl8M4tsEF9y7AwP5InMsJHCkQfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800099; c=relaxed/simple;
	bh=3CO44iNrPAkdfYLxe1mcSvtJfmua9dBTiPyw/Zw6zgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEmmLkVqJWgw0E4bWKJAl2yPaIv6RvlcajhuLg1jtyz1iCWMJkvetJElGVU/sfDcWTMcoEFtLaFFwx4EizLZyk2dvjel7thSmMG6PeZcvhViUUTrD2jBpbtXBoqFr9UqDHR1Oc6PTpIuiwlsktOMRodQIzxiOpy7E5eBpe2Bz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlyzrF/X; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlyzrF/X"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45090ef26c6so834488b6e.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800097; x=1768404897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n8Kb47Rl130Byxu0ad+8SvRWtkqSvh8ZeidUsu8Q2I=;
        b=UlyzrF/XmN05HA8PEjpbuqMKIxx6O8wSt2fCFJoABez6wlizZ79QjgpsYRx/PagwSv
         aFSZzo0XW7wjrLvKNUbPNWYGGdtU0/YPxOJbWREdy1/XecdFZNmiL85RnhW+HvdjT4uI
         WGo8FT0h1ziCxDr0ibrUqSNq9TnHnncITTFvgYI3O3d9nZhM9BB/0KvupT6d5TlNYykt
         5auxcqE3iDkoH2Btc7JA9ecrgsh/VNTLoNfp3hFq1IQb70zhvXL2ixaTfkQr+/DMuhVj
         yl981S+hkIE3mf2MImnTIMl8GzQ0akcPzC+l5xu8jUWWIXH9OYGdiSLi8l8JOVvbY+cE
         P3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800097; x=1768404897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3n8Kb47Rl130Byxu0ad+8SvRWtkqSvh8ZeidUsu8Q2I=;
        b=ueW0iXQgAZA3CgthfIXuHUpaLdRa8IlGgzKNS5wY6IoR0m/0XzqLgJ4IGyO6noJRGn
         RblJw0CUOg4bnCihQ2FLMgedb1xNIbTvVbdr+yus1hqVmM1t9gSmhaT1CxF/Qe0R2x3l
         OgS0AxJRCrZuxgDJy/acvtfgEJCT5LjZ0/H1vDam075sCOKIvu3cHj1j6sQ7x/P/JK1+
         +v3oYD29osY+zKI1ebX5y67xpl5vZUs/MS9RMSCSB7ghSWQO1iHvXcfaiYiAeT9rCV2e
         bi/N90XwzIMxU+y/dbwV9Twi6+b/5J/JjnESNnFiKW02zqAMRMk8lk4izhBlQgDZHTUU
         1HhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRF72gKykA/zIP+qDeu09ALIF5728FNvFCaoWJUj9diLFzBW8jQq38LdeRE56KP+yMqi9BqX1SUq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsCU3lgzSRlrfojHcLV7YSCuqzRWmrbi+QE95WFqKfSYqTuOj
	4Q7S6kBTqbbAg6blN1wakmknguP7nOfM3/YhByXi781EE2qYgJpKPHfq
X-Gm-Gg: AY/fxX4cI8GhmyqHoTyOGt8tepbpzSE7vTkuCDrpLfb36VHYmsVeXD6i65mFpSxbC4u
	/ttbuIcboKNu2RD98HATlwcplExu55EQX7emfFfBAD7HZlRQBQw4swHgI0DSKCxs8g0a+oQEnKN
	N632CQ21HiN7I7s7UxGnkDfn+10D27JI+eyE9EwHPFYH6vGIRDo7I4ddDf0IsoZlrUoz/+uLJy0
	J6ZEIZjarVXep5I4U/jeztmYjmkD3eu1byJ8knaD0538+knb78ZlammdFPZ1+K5MOv2ZKg47Pn1
	zb0GelE7n1R8qBbnJh2Nq94m5rude5+1h6IlYLEtmXUA37+iAgPVqCHrFoVKoFiHYnIgxLdUimS
	SogJIqFKA2srK/eNKnFCEcqXadAs38ghF9klLOnhkoheP+b6Jkk2vFh+l4kuRE8vfX1mrZG3OHF
	6Nz+bBfdXiQ8EDDvszTxuJ09WUC9TpA8AaqBa0CUrtnFmD
X-Google-Smtp-Source: AGHT+IEkv++nP1XZgFGglQlyqUlGW3kCUi7rPnay9ZMhKErbt4qPcz86yrkR1ubRTqfHLlOPMJj8bg==
X-Received: by 2002:a05:6808:16a8:b0:45a:55e6:f5d6 with SMTP id 5614622812f47-45a6bd87897mr1217540b6e.12.1767800096765;
        Wed, 07 Jan 2026 07:34:56 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm2398424b6e.4.2026.01.07.07.34.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:56 -0800 (PST)
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
	Chen Linxuan <chenlinxuan@uniontech.com>,
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
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 3/4] fuse: add API to set kernel mount options
Date: Wed,  7 Jan 2026 09:34:42 -0600
Message-ID: <20260107153443.64794-4-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153443.64794-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153443.64794-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add fuse_add_kernel_mount_opt() to allow libfuse callers to pass
additional mount options directly to the kernel. This enables
filesystem-specific kernel mount options that aren't exposed through
the standard libfuse mount option parsing.

For example, famfs uses this to set the "shadow=" mount option
for shadow file system mounts.

API addition:
  int fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt)

Signed-off-by: John Groves <john@groves.net>
---
 include/fuse_lowlevel.h | 10 ++++++++++
 lib/fuse_i.h            |  1 +
 lib/fuse_lowlevel.c     |  5 +++++
 lib/fuse_versionscript  |  1 +
 lib/mount.c             |  8 ++++++++
 5 files changed, 25 insertions(+)

diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 016f831..d2bbcca 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -2195,6 +2195,16 @@ static inline int fuse_session_custom_io(struct fuse_session *se,
 }
 #endif
 
+/**
+ * Allow a libfuse caller to directly add kernel mount opts
+ *
+ * @param se session object
+ * @param mount_opt the option to add
+ *
+ * @return 0 on success, -1 on failure
+ */
+int fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt);
+
 /**
  * Mount a FUSE file system.
  *
diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 65d2f68..41285d2 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -220,6 +220,7 @@ void destroy_mount_opts(struct mount_opts *mo);
 void fuse_mount_version(void);
 unsigned get_max_read(struct mount_opts *o);
 void fuse_kern_unmount(const char *mountpoint, int fd);
+int __fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt);
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo);
 
 int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *iov,
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 0cde3d4..413e7c3 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -4349,6 +4349,11 @@ int fuse_session_custom_io_30(struct fuse_session *se,
 			offsetof(struct fuse_custom_io, clone_fd), fd);
 }
 
+int fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt)
+{
+	return __fuse_add_kernel_mount_opt(se, mount_opt);
+}
+
 int fuse_session_mount(struct fuse_session *se, const char *_mountpoint)
 {
 	int fd;
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index f9562b6..536569a 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -220,6 +220,7 @@ FUSE_3.18 {
 
 		fuse_reply_statx;
 		fuse_fs_statx;
+		fuse_add_kernel_mount_opt;
 } FUSE_3.17;
 
 FUSE_3.19 {
diff --git a/lib/mount.c b/lib/mount.c
index 7a856c1..e6c2305 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -674,6 +674,14 @@ void destroy_mount_opts(struct mount_opts *mo)
 	free(mo);
 }
 
+int __fuse_add_kernel_mount_opt(struct fuse_session *se, const char *mount_opt)
+{
+	if (!se->mo)
+		return -1;
+	if (!mount_opt)
+		return -1;
+	return fuse_opt_add_opt(&se->mo->kernel_opts, mount_opt);
+}
 
 int fuse_kern_mount(const char *mountpoint, struct mount_opts *mo)
 {
-- 
2.49.0

