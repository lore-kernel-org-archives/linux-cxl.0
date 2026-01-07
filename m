Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F90B399035
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800104; cv=none; b=OrZ8z+eCsHdWb9P/WfZIGzEGRWsu3QEg30xPwCjqUGd+194mOWHbi53SRdByIAV8LJtqjl2AYsIlVffYFthzSeN/vemUaqFfbrJhSC2N/iHRBWYDbD0JhXWqNyPyY446GZ3ukHTHtuhXhqpwc3lGqmRLhDmCIHdy5Nw2t1HyDUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800104; c=relaxed/simple;
	bh=HM4lKamXQwEUZnRqp2/mgy4o0pjN0zbCyAQ9KEkrnNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuXhDV0ccsiBAiYx1NONQ7GXrAlIIUpSNGPBXO8fZ9WaqQn1TKavRtoZddh9lUsrNd2XFzdG+iGT1b33hOer943hQPC792ysxzRt/JOEBUM+6m6cBlA1a003HxddGigHpUdFOWCebWxjB4uT8RpWggOJs4416UxCt0wSCzchM9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBfRge6Z; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBfRge6Z"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-450b3f60c31so1049994b6e.3
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800099; x=1768404899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPrNuirfi0NELPHMFcu/1KlJClDuCwOT8DJm2N/JJag=;
        b=TBfRge6ZoGYJNVe+MfO7B8Q/lEdSD76bj1t7mMM11HcoqkehMf7mYPh6Br09hLbmwh
         y5aMVudtDQjn9njNFVyKm4KX8K6HPC9G1m2LTLxOTYg8eCLtKE4p/qAEEvo6YzWRuHtW
         NdwWCLBC+PnDiHoahfPE0Kdc3e9EZRSWIiFGx1np9Vwxfs5x5NQ53vKDhtG4cWTXjTXR
         Cl+zwf/ufAj5/JpjyWYyyz7eH3pOHbDEAX3WCpWYztlP6NXg3E7CujM3RMhrebI/iWts
         kIwDZ3OB6Z32qnSp4QVo8SUwFMQ31YEstNwTC/Fc7lpl/JGrYHY3yx4MA72PakPxGF9S
         wIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800099; x=1768404899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPrNuirfi0NELPHMFcu/1KlJClDuCwOT8DJm2N/JJag=;
        b=svwS2f1Lcol2w7G+XQsJt3+IOLDSrg8oIM/C+VZwEU0cHg0UYEEub3gN7+eoaR+uXz
         ZMGjFlJ/BjjhAhNOTWLN+N5l0ZWzhiByeAkVSstt2O8r0L12iBA8jDF3h7+c+aeo1mrA
         r492KbhsCMUO4oDH2F+A/d+SdwGMX2S+mCeB8PRamCCSFfb2NtbQ4GSz13h7BzIOzD6E
         /W4mx9SYGxjQ5gV74FEq1epooWPKyqfBRNuT/wegWPPaJaYLN1qzCrvwS8UM0XS5dU8V
         0ASnTpiGlXIUSjQEhWcnbFkrJxIMzAQzxwW74d+QuSa04frKtNYk0S0mWaD/AOvav0/X
         7i7w==
X-Forwarded-Encrypted: i=1; AJvYcCXF2U2cfooIo7BrC7HHybg2y0xGIAXGRqLja23ySuJ6yMDgeBIScEAePcLsZUZLiWskNPZ7oQVX+as=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkOMXxrWStFNbBJ558ZV8LPptW9y6f5OouKn4B815zN98s4WO
	U+pStAUOlNIv2hP6n/urTqdygshiYojZ1/iWLGvfW/VpagV8jvBQTJBh
X-Gm-Gg: AY/fxX5HyzBs5XyQganQHuDchN6aJTgf73Kd/Axr4UKciTZixRjl7IybPfPBqhMpkeM
	Ey4AeYzgTEyFZ/7KFE/bTtTV6VdrwKOg5O+yH2IuHAufPxr9VUk3vHBwzjpF4D7Ukj7byGJ8ZKp
	6GYDlgPvWo432KzayBgBqX5MXkb5zyijr+Azz+Lz/COX3tbWCMKyQ+52R1RaObyUfpVuWMKPW3g
	Dr69OQaY9AfKCl+vxAdhny33HtRHoN6gFdZJTpdOM6c7oQ+/lvKwmarvP/prJ7U1YCV9ljrWJry
	TJkqgUwXSPXazzVHpRmMGZwCuW+DVm/t7A9y38tY+Wio0whj93/OWQxwdYuxKfpyS1J7pIRLmSb
	pocKhkJ48iX0ExTnYd4vYAYcOre+gl/36RaGd0mLS7n+ymSg+iIUTpal4uzI4h7CKwWd0UDXD6f
	SMPzRCTShlWK++oeD6ecnbpAtmWnd7+LV5W8YTHAxMiFxK
X-Google-Smtp-Source: AGHT+IFUAwqlKPFZxOP8hKjN3yWWiewXwLTUZV8MqKGeOfhFctvOkPQ3NvPc2aDZQl4je/LWLvX3LQ==
X-Received: by 2002:a05:6808:3206:b0:450:c877:fd6f with SMTP id 5614622812f47-45a6befa901mr1333720b6e.67.1767800099405;
        Wed, 07 Jan 2026 07:34:59 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm2398424b6e.4.2026.01.07.07.34.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:59 -0800 (PST)
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
Subject: [PATCH V3 4/4] fuse: add famfs DAX fmap support
Date: Wed,  7 Jan 2026 09:34:43 -0600
Message-ID: <20260107153443.64794-5-john@groves.net>
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

Add new FUSE operations and capability for famfs DAX file mapping:

- FUSE_CAP_DAX_FMAP: New capability flag at bit 32 (using want_ext/capable_ext
  fields) to indicate kernel and userspace support for DAX fmaps

- GET_FMAP: New operation to retrieve a file map for DAX-mapped files.
  Returns a fuse_famfs_fmap_header followed by simple or interleaved
  extent descriptors. The kernel passes the file size as an argument.

- GET_DAXDEV: New operation to retrieve DAX device info by index.
  Called when GET_FMAP returns an fmap referencing a previously
  unknown DAX device.

These operations enable FUSE filesystems to provide direct access
mappings to persistent memory, allowing the kernel to map files
directly to DAX devices without page cache intermediation.

Signed-off-by: John Groves <john@groves.net>
---
 include/fuse_common.h   |  5 +++++
 include/fuse_lowlevel.h | 37 +++++++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/include/fuse_common.h b/include/fuse_common.h
index 041188e..e428ddb 100644
--- a/include/fuse_common.h
+++ b/include/fuse_common.h
@@ -512,6 +512,11 @@ struct fuse_loop_config_v1 {
  */
 #define FUSE_CAP_OVER_IO_URING (1UL << 31)
 
+/**
+ * handle files that use famfs dax fmaps
+ */
+#define FUSE_CAP_DAX_FMAP (1UL<<32)
+
 /**
  * Ioctl flags
  *
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index d2bbcca..55fcfd7 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1341,6 +1341,43 @@ struct fuse_lowlevel_ops {
 	 */
 	void (*statx)(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
 		      struct fuse_file_info *fi);
+
+	/**
+	 * Get a famfs/devdax/fsdax fmap
+	 *
+	 * Retrieve a file map (aka fmap) for a previously looked-up file.
+	 * The fmap is serialized into the buffer, anchored by
+	 * struct fuse_famfs_fmap_header, followed by one or more
+	 * structs fuse_famfs_simple_ext, or fuse_famfs_iext (which itself
+	 * is followed by one or more fuse_famfs_simple_ext...
+	 *
+	 * Valid replies:
+	 *    fuse_reply_buf  (TODO: variable-size reply)
+	 *    fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the inode number
+	 */
+	void (*get_fmap) (fuse_req_t req, fuse_ino_t ino, size_t size);
+
+	/**
+	 * Get a daxdev by index
+	 *
+	 * Retrieve info on a daxdev by index. This will be called any time
+	 * GET_FMAP has returned a file map that references a previously
+	 * unused daxdev. struct famfs_simple_ext, which is used for all
+	 * resolutions to daxdev offsets, references daxdevs by index.
+	 * In user space we maintain a master list of all referenced daxdevs
+	 * by index, which is queried by get_daxdev.
+	 *
+	 * Valid replies:
+	 *    fuse_reply_buf
+	 *    fuse_reply_err
+	 *
+	 * @param req request handle
+	 * @param ino the index of the daxdev
+	 */
+	void (*get_daxdev) (fuse_req_t req, int daxdev_index);
 };
 
 /**
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index 413e7c3..c3adfa2 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -2769,7 +2769,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 			se->conn.capable_ext |= FUSE_CAP_NO_EXPORT_SUPPORT;
 		if (inargflags & FUSE_OVER_IO_URING)
 			se->conn.capable_ext |= FUSE_CAP_OVER_IO_URING;
-
+		if (inargflags & FUSE_DAX_FMAP)
+			se->conn.capable_ext |= FUSE_CAP_DAX_FMAP;
 	} else {
 		se->conn.max_readahead = 0;
 	}
@@ -2932,6 +2933,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *op_in,
 		outargflags |= FUSE_REQUEST_TIMEOUT;
 		outarg.request_timeout = se->conn.request_timeout;
 	}
+	if (se->conn.want_ext & FUSE_CAP_DAX_FMAP)
+		outargflags |= FUSE_DAX_FMAP;
 
 	outarg.max_readahead = se->conn.max_readahead;
 	outarg.max_write = se->conn.max_write;
@@ -3035,6 +3038,30 @@ static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 	_do_destroy(req, nodeid, inarg, NULL);
 }
 
+static void
+do_get_fmap(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+{
+	struct fuse_session *se = req->se;
+	struct fuse_getxattr_in *arg = (struct fuse_getxattr_in *) inarg;
+
+	if (se->op.get_fmap)
+		se->op.get_fmap(req, nodeid, arg->size);
+	else
+		fuse_reply_err(req, -EOPNOTSUPP);
+}
+
+static void
+do_get_daxdev(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
+{
+	struct fuse_session *se = req->se;
+	(void)inarg;
+
+	if (se->op.get_daxdev)
+		se->op.get_daxdev(req, nodeid); /* Use nodeid as daxdev_index */
+	else
+		fuse_reply_err(req, -EOPNOTSUPP);
+}
+
 static void list_del_nreq(struct fuse_notify_req *nreq)
 {
 	struct fuse_notify_req *prev = nreq->prev;
@@ -3470,6 +3497,8 @@ static struct {
 	[FUSE_LSEEK]	   = { do_lseek,       "LSEEK"	     },
 	[FUSE_STATX]	   = { do_statx,       "STATX"	     },
 	[CUSE_INIT]	   = { cuse_lowlevel_init, "CUSE_INIT"   },
+	[FUSE_GET_FMAP]	   = { do_get_fmap, "GET_FMAP"       },
+	[FUSE_GET_DAXDEV]  = { do_get_daxdev, "GET_DAXDEV"   },
 };
 
 static struct {
-- 
2.49.0

