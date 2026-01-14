Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0935EDB7
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426468; cv=none; b=nZaCpWdd4k2qK/+O5B3c9p+ux29fzBVIOqQmepowfxXKyW9FYhn+fGJhGIe3L3hDUI6RnbxDlziKG5n9QN3jWLhzOJC2jwii/EkZ/kZ78gFdikJIdOjmvcecjZC0WI0aXW4spI/zkhQKEVkso3NQjXoBqXoD9hmKer5X0/kbjpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426468; c=relaxed/simple;
	bh=9in78rjKHXFfg7w69sXqer35Ki4r88+O4RkMgHiDMEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn+oXJ2rictlJ8kHuYIQeppeDehbHaIwWex403nGNbrliGMITkEXbpgNQSHuwo1/TkB+9brI8Amvs0TR1cPuWOvlzfjnOGfIBwBn5X/8zgFK+AthC6rSwhRX234jQxrPuiQQYJh+ot0BfgSUD+Ea9T0Ij2AxMDldzeeE9hNoxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjcMuL4d; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjcMuL4d"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c78d30649aso187240a34.2
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426464; x=1769031264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7XgQVWhUwcysFnko8qRq5dHQ4c7d0Rm3BbWfFJ4FJk=;
        b=SjcMuL4deu1NsK0EMJDaqTXuowbQGPPxISLQJuXZf5Qyl8iDkJo2P1taJR2AvaWizz
         aMG6IlDShoxm5DW/m/bmqEdP8GT3kSypfZ3yNbRCgVe/b9+zp+VPmHkZ9TlIOBXKKT7Q
         V9YmKhAgl0gqxIqvYns+F8AlYo3TMV7A4idahPi0fpL3A1Rut0Z/fsYXBAVCTnPFLPTj
         fyuVlnMWWRNaSU2up977pIGsGwy8nVeg4B8NDmTnL3qDo8ToUJ/8inuWObz1ACdrKoCc
         0gJiYg4OGvNG1Tnlul19cusDKGY7lkN3iX5Hb1XUSvPLBCW7/Oxv04EANxgwaAtoXC9l
         jXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426464; x=1769031264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7XgQVWhUwcysFnko8qRq5dHQ4c7d0Rm3BbWfFJ4FJk=;
        b=d19qw/v6KDoBdDauyOiQ+fiEG2HYCW+uDl0CKAz7VLwnwG25Gm/EBADg02wEHMRllg
         ezsY/Beyg9/CYGbdUbHdG0qOduIsiMGrErJAbQIelM50GeyCZ0h1nOM2Txtv5TnRM/Cr
         fO+CMfHv2fyiekNNoN4YEk8oVwb9S4L/1/qIpGimBzsLwA8kgITn2xTLrBymtS4y9tR3
         Dvns6rv0I189qTt+iztenyzKpgeab+vbZXtqW5nHkcqx2sypO8vaHh3AyNBpJ1n+yMU4
         nNOt70yuIBubxuwRuy318qE3ju9BfgurpqLFfYheECmYlvqVz/ZM4vi5ita72O0/T35U
         POgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO6KfAXuDsWM3dxsq0RMwOgmlntR4HL94K4NXJRsdUP0F4wSOdtBrJ6nBBbgbpRwto8BsCXOCpzb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7rEtV0Z1op8wFQfjDGbPncxl0P29i43v54H53qwOcrD+nm3v
	rU3FcHvEOD1qzcF2tAWWphYbLGtv//netk/87ZVFydgwK8Y8bOsJFC5k
X-Gm-Gg: AY/fxX5UESfoieJAuMPTksVlhImk+4bXMm0yfxTAngzEhY7IRF5+A+NjIu9c2OQ8Q6W
	psyjhFsJKgT31gspVJ2jekNpHx97Xda/RcjYFEJo8bceIg21QEWxdLwfLH9TuaUXCAvEAT/1FC7
	+kLxnb1PeM9FVRqP6LXREd0mUlAX2F4Cp3A7oq61fMa2C8QUltuUq3pQFIVrrZ2CNLYF8HDVUqG
	XUwHpzsQOUo9in2jEonAWSzbO9XiIYQLwyK1AQ0D9EoA4BZEPTZbCpifcaFuGOua2fdOKGGeeXa
	i4A+JEEZqrK/SPLTFHRJdu3BBLZ65rT9pQKo0+q1FmsRTFYDvva6WX8lxknSB7YEL9RN+/lFOJW
	3hv9SMQ866gtripBEAw0/c1X5a6YiPknO6FE+H1u9zLZseuJ3daByYwnbOk6Y8jNsJwYnLVsVQL
	Hih8FX55Qkk4kofzHbqxNXOLOvQSCwTaQkA4rUCM0qCN8m
X-Received: by 2002:a05:6830:1cc2:b0:79d:eccc:96eb with SMTP id 46e09a7af769-7cfc8b3a75amr2512388a34.26.1768426464258;
        Wed, 14 Jan 2026 13:34:24 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478d9c2esm19771776a34.21.2026.01.14.13.34.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:34:23 -0800 (PST)
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
Subject: [PATCH V4 04/19] dax: Save the kva from memremap
Date: Wed, 14 Jan 2026 15:31:51 -0600
Message-ID: <20260114213209.29453-5-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114213209.29453-1-john@groves.net>
References: <20260114153133.29420.compound@groves.net>
 <20260114213209.29453-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the kva from memremap because we need it for iomap rw support.

Prior to famfs, there were no iomap users of /dev/dax - so the virtual
address from memremap was not needed.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/dax-private.h | 9 +++++++--
 drivers/dax/fsdev.c       | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 0867115aeef2..f3cf0a664f1b 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -67,8 +67,12 @@ struct dev_dax_range {
 /**
  * struct dev_dax - instance data for a subdivision of a dax region, and
  * data while the device is activated in the driver.
- * @region - parent region
- * @dax_dev - core dax functionality
+<<<<<<< Conflict 1 of 1
++++++++ Contents of side #1
+ * @region: parent region
+ * @dax_dev: core dax functionality
+ * @virt_addr: kva from memremap; used by fsdev_dax
+ * @align: alignment of this instance
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @dyn_id: is this a dynamic or statically created instance
  * @id: ida allocated id when the dax_region is not static
@@ -81,6 +85,7 @@ struct dev_dax_range {
 struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
+	void *virt_addr;
 	unsigned int align;
 	int target_node;
 	bool dyn_id;
diff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c
index 29b7345f65b1..72f78f606e06 100644
--- a/drivers/dax/fsdev.c
+++ b/drivers/dax/fsdev.c
@@ -201,6 +201,7 @@ static int fsdev_dax_probe(struct dev_dax *dev_dax)
 		pr_debug("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx\n",
 		       __func__, phys, pgmap_phys, data_offset);
 	}
+	dev_dax->virt_addr = addr + data_offset;
 
 	inode = dax_inode(dax_dev);
 	cdev = inode->i_cdev;
-- 
2.52.0

