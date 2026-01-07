Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F54396D3B
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800079; cv=none; b=RjK7R7H6Q1A3aj1jw85wCVFWK1cLlhONVMLML4NH9A8MUYPMBSUEqyiLQkXELhfrAzwCVFR9XJbe1E58G9agOLFEXuNKS8Edkp8ru5pBK4Tmq0rlKz4PiBz1/afEX0brugYeUEyDns01X8Q534F7ECMwyDHBY2xOUoybC249KPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800079; c=relaxed/simple;
	bh=zQL6OSWBO4m5+Q/hEBIHqSQry3+21Rl32A58FZEFgEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozirkMbOegIVMNQL6qmqbqzastf1VOEF836x7hvQkTT1SxkzMAgUib57ssmdQxC4F76BQozmethYjqwDwkS1MfnTkdW1LS7dWRuvmeqfIxoaQtqgFtbxhyXKundihdUP1HPDHTMCu5p0DiPTBsIF+rIVj6P8Kmt7PGyNIsqFSwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JleWKWKK; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JleWKWKK"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-455ddb90934so748024b6e.0
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800076; x=1768404876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BadRqtdIUTjJqSpAIjL5u97iCPqnyeMr+lfViz9uPAM=;
        b=JleWKWKKZILs4kfdIcm67y4G/+cPmDE8Eh9sSBPGt8bosmO1BQJxYUIciTesaGkZmH
         k0maEuJOCN1txO0Z7yGlpuIhvRNEsqbFmd1MSV5CW8soCIdpxxaBe86ybTym+zFpyLxS
         vOZqtX9lPTNxRb2WPcBCecXuBpGFS4wJqaugmG2/Wh2SGPQIR8A4dTj4KdU26/LSYrEI
         KUpnS2wdi35TkbpjN8hSHcToVQBtSn+585t54AkDJ0l3tCYLn/ZcRjYtr7GzXrxyQlns
         42Br/b1X8Q6gPMm+2MwNgSjKbgq3skPX0nPs+yNOPlfJcVFHeLi1FlBBFX/seBcp6urb
         elfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800076; x=1768404876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BadRqtdIUTjJqSpAIjL5u97iCPqnyeMr+lfViz9uPAM=;
        b=HduYqRrakMVMS/wMGEZllHQBZNJudaQlTxi+/mosR6FFaWJrauW3Hh3SjFXk/9sz6k
         9UqT+qWfcZMiyvDBbXhgJ+ICK7o2kzpMPgTy0zmZF7wLfm+soGHlm4U40KEWJn1USbNU
         ffZdvc2FXQ8yCGIq1H84jq9Om0KI1cytMEZ9o2lrQPOdtM9thCkXQUhATWnzNcxl2Yr5
         /GoyV0l9SOohohAS1A0VYCfWRoPRbqKV32P2g04TqF4SvGouMWBl0xqXPmpQoIoyErZF
         G6YcJ94Gc0xfBXBXY1X+EHm2DBlarCHE++SPlMVlawiH4o9y/8XDUVZQ60d4c0oQEE+T
         cJfw==
X-Forwarded-Encrypted: i=1; AJvYcCXFzmOHAULrAOorQTjeMVkM8F4kPTpMb4lcYkS6TInaCOHA2aFuU/0f9qqXAnwD7JgRY+hR8qutgUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZw0zR1MGZAC6Ptr70kKqDGskM07vmTNhtazGFHfT0vY7w+NdF
	Q+6m76PjqeaH9L5YRer1/Lx0U3WNlqwnFa8h4abU0XGysPeSR/DS0Xrz
X-Gm-Gg: AY/fxX6R3Rj/P5T5724bjTYSy4flVHlYbKFh/le2CYPzKYFWyd2QjqJtc47+xa1D26v
	+rULwC6OGBp8i4bJrwtzvHQGjbFBFSodyWrhKlu/IpAlMkwfkdqSpDK+qfiPWUL3/nAX8qnERcb
	wEOxSsLAsuUDyBtoEFTdByLCsnyX3uPxbQ4Dzx1Y9HBAoao3bh7F09UIrjtAfB8v7RvxrWrO1tm
	l/ZuiTBUYjGsRCLGhK2UT33lEAybgwbFt8nkhEwYvOZH72JKEZmRcDSiVtH0uXq7vsrRbPN7i74
	l90K3ujbWpTexJDhCYggjJUgS4RCUqB7p9xAlXQ0Wnyz0/2tqsB65o43zB9aZWP8iaooylwRmBa
	Vee//N8xMNEdU2SpveEBbb54A8AYxtIQEAi7qrsK0guYbune/r562CZPXWTNZ86mgO4saTz2med
	ZmIcQblb6zoXtAJOwO2pRAaMKOjM7c3eMi7rdI9zvP68w9
X-Google-Smtp-Source: AGHT+IGiBgbbbwZi9OtjHC2lwZve1mJRhadFMJn6qeQ/EHq2CoD4bMYUWvkIfhWahXqGzzsZgFZhkg==
X-Received: by 2002:a05:6808:2383:b0:45a:156f:dbcd with SMTP id 5614622812f47-45a6bf2a83emr1169537b6e.62.1767800076370;
        Wed, 07 Jan 2026 07:34:36 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:36 -0800 (PST)
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
Subject: [PATCH V3 19/21] famfs_fuse: Add DAX address_space_operations with noop_dirty_folio
Date: Wed,  7 Jan 2026 09:33:28 -0600
Message-ID: <20260107153332.64727-20-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

Famfs is memory-backed; there is no place to write back to, and no
reason to mark pages dirty at all.

Signed-off-by: John Groves <john@groves.net>
---
 fs/fuse/famfs.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index 4eb87c5c628e..32c3d0c2ec48 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/dax.h>
 #include <linux/iomap.h>
+#include <linux/pagemap.h>
 #include <linux/path.h>
 #include <linux/namei.h>
 #include <linux/string.h>
@@ -38,6 +39,15 @@ static const struct dax_holder_operations famfs_fuse_dax_holder_ops = {
 	.notify_failure		= famfs_dax_notify_failure,
 };
 
+/*
+ * DAX address_space_operations for famfs.
+ * famfs doesn't need dirty tracking - writes go directly to
+ * memory with no writeback required.
+ */
+static const struct address_space_operations famfs_dax_aops = {
+	.dirty_folio	= noop_dirty_folio,
+};
+
 /*****************************************************************************/
 
 /*
@@ -657,6 +667,7 @@ famfs_file_init_dax(
 		}
 		i_size_write(inode, meta->file_size);
 		inode->i_flags |= S_DAX;
+		inode->i_data.a_ops = &famfs_dax_aops;
 	}
  unlock_out:
 	inode_unlock(inode);
-- 
2.49.0

