Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD9389470
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800048; cv=none; b=QVY/M2BFnMjulBhBOsEkC0wGzz4W1HkBYLw3EL+uJjV51W4KCbg//iPPTQJO6nMBwYYoHzd/YcojaQQZvVr3dZT+GJ6abRgI5tCfaLuIgfpVZvwYKEFz1YLE0tMufr8nat2LJScjHlEdJlcnusvc5SMwCgzKiQz8LeAsL3Mi7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800048; c=relaxed/simple;
	bh=rXk3y4C8WJeOSfMI8cZ5ZlL/TCkv73ERx5NvQkCSpyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olTVSlzPsAb20YNfOv8sTpg6N4F+iLrz2Q8KH4ZqEpt5dOJro7+kspSwiWOrn44/zHkBI7lP+4D66ltG8wN8OGTbOQpL+b5k8gkT2RzZqFMxEA/JtWdMSBXmXoqAj/NneF8vOO8Y2FMJdE/IgUmxowC2s6+FaDzOUafL4ajh6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4GZnOim; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4GZnOim"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-459ac606f0bso1285262b6e.0
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800045; x=1768404845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nEjVEszBS1bXBch+QTu9nax0OtrFw3AqtXa5XoSe9fA=;
        b=G4GZnOimGKYLaHQGRjcwbXlnk11Hf9ZpstIvvG+0jiRuMet2ipinn4hboqAiV/4XKU
         yZo4+HdbHWHL/gZz9FrZ95shPbqvj8ssUBjlKn3Ca3futo8WkJmJDXdA1vN9p3X2qt6A
         qi4bBIojc8Pzmcyy06LC47Hk53pQHCRdibIi0tfU/kCsHXrVqe1DzFmXUhC50GkGRWb2
         52lVIoswD4+b0GJM6x0ps+eK+B6WBo4vc7LGsU0EzzEqQkJpMoKbohZplLpxxCODZfq/
         u7KxjGCjENGGHp0bxE8yTSNFTnTaGIgTMeiQvNfNKiGvzcXhMZCTbnSakdMEPoVCchdS
         AASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800045; x=1768404845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEjVEszBS1bXBch+QTu9nax0OtrFw3AqtXa5XoSe9fA=;
        b=EO//Y6HGCjhOPpgYYzAwN3DZf4U/Ea+6uGRpAd68Q9SkTC7WNN3a4sWfWGK4yf1K5I
         9XbEudwRi3tssRMbUCaD6PVQsiYb2CMxgC7PVLKeGLqOG1mev1IgHc/UnFtw6JPv0x0+
         v90Gmy2smbo23uePBkfxYSvvxqvFIaf3cshJgn4zax8QNsAbshFzzrfBRsipe8b0OCme
         C2mn7j0G4I8yMq2eMGWmc2CFyyOPkEfDE8klEpdH8afb7Ku9kP/uvHSh6UMUSjgk4iu4
         wxuruTJoJan+1FlMDdjEB457MKj6csjz3rLjPXXbJS6rWzWjy9dSUMQn7DLqI9lnxV6D
         iNpw==
X-Forwarded-Encrypted: i=1; AJvYcCVC9uM41ywlVlUkOL4IaoooBVWvxzFRBl8PK9YMWwwC2N7ATC19wIjqWjYwAsafzfQ7mWgUlrBb/Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5LMOLCZGF/Ke8KNss3A/gGG9D5EgGdZwwc4HK8BhWIQ7iWZ/
	A2F6XejIjJ46TQGE4wHWaXqJI8Zsmt998EXoTMPcnvBibm8fKANS1t23
X-Gm-Gg: AY/fxX7ULAZavzWo0ODyMoVVB26kwf97T4Iz1oebjd2ceAhdNw2yFgAUJBOhxDp1B1p
	WWX2aL+CuaROrYbTM+hBHZRKRCPrcEBEsRezJfoVWXSsJvVVlYeUUPrqfikap7HZm7igVTCKGvb
	0xopkayeux+wneFardWKBM7M+7mJw8gxGQcNhjsqF8wlp5hrlpdr9VnwDDHkZWanEMR4K/tMK5/
	nK3T54wbACCVn3yeewCdmEaDKiytHJu7QfBxUZbVmWIuoBV2hewTxZuzJvOtKWr2MF3wpJH4zca
	HEFoet3vFS+Ax9qKxiNUMy9RkUpJxP2K4PcBlVK5vefvdyiVWJsJLVpStrzlfz/NW49muzDezsh
	VxrNxMQbq8FzoxDV3V8Vm7iq+kjyHXrLcoyEtKNgUt5phuToqvfWR9NjN90xGCdkrfaCrtg37fD
	3xtQE0uTb+Ku0XGbhOPzGq87oZUfloQpfq6TnwbnzjuC/10ptCYACRQQw=
X-Google-Smtp-Source: AGHT+IFX5hj+WsCZcQN0F9ui7U4tLr7OXye3gCol3kbUSaMg5lrVm0TVcSYSe8f2gPxdB0ZE4wEzIg==
X-Received: by 2002:a05:6808:c28c:b0:43f:2a62:8b79 with SMTP id 5614622812f47-45a6bd4ad18mr1041781b6e.29.1767800044921;
        Wed, 07 Jan 2026 07:34:04 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:04 -0800 (PST)
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
Subject: [PATCH V3 08/21] dax: export dax_dev_get()
Date: Wed,  7 Jan 2026 09:33:17 -0600
Message-ID: <20260107153332.64727-9-john@groves.net>
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

famfs needs to look up a dax_device by dev_t when resolving fmap
entries that reference character dax devices.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/super.c | 3 ++-
 include/linux/dax.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 68c45b918cff..c14b07be6a4e 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -511,7 +511,7 @@ static int dax_set(struct inode *inode, void *data)
 	return 0;
 }
 
-static struct dax_device *dax_dev_get(dev_t devt)
+struct dax_device *dax_dev_get(dev_t devt)
 {
 	struct dax_device *dax_dev;
 	struct inode *inode;
@@ -534,6 +534,7 @@ static struct dax_device *dax_dev_get(dev_t devt)
 
 	return dax_dev;
 }
+EXPORT_SYMBOL_GPL(dax_dev_get);
 
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 {
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 76f2a75f3144..2a04c3535806 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -56,6 +56,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
 int fs_dax_get(struct dax_device *dax_dev, void *holder, const struct dax_holder_operations *hops);
 struct dax_device *inode_dax(struct inode *inode);
 #endif
+struct dax_device *dax_dev_get(dev_t devt);
 void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
-- 
2.49.0

