Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7401389463
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800050; cv=none; b=A5XLKdL6MhhMRIRzLkMnnqqz7eOjfXjPFrn9b67VAr3aE5W/gzkxdSoWlsJt+8ob02cTfDl+ifsEd6/dh9VTzrskA3Mkn3QfZL82AzAoT7kd/Wqqc1iHnr2I1lFIja/A+g2hyZ8tgNTlU9r3t+z9aMmKZxbf51I335oP+rSOjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800050; c=relaxed/simple;
	bh=G0p06p4Oj55Eoe9gPvplGLniqIrk/l49GkW6H+icHvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBZcRLYS8DQDUuoyIvNJ45kt6jJx/oD3BEZJ8rlHSAVLWXB3bmBFHIOJWFCkZhp9qvjDAeYv6XjzylzGv4mvhX593hhvWtZW2C46eF+Ek5NV8fXmsgwGmJGo1suN77ifVZEHsy/SLyvS18YLA9zCmeCU9rTl3x8XV92XOrNoi3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFpr9umO; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFpr9umO"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-450c65f3510so1427095b6e.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800048; x=1768404848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO9EJ1SzMv+Xy0KnqPrEHfvHLOumowI49Qpx0L6iCR4=;
        b=WFpr9umOXk3BBFeUe/mPboHm7D0pgGFB+1BB2X7hNWI2t+0tyMml5JDSL1v35KrOQK
         9bSl416Mg7zGl+XaNaKe6fcqQDcSooHqQrP9M8+dG4qV3eMHeOl5QplIkjCYCdYTNyBW
         c1kt6GwVqdQMiT4BFJknc1tS5BA4eEPmeaY6mYi3xq12EmvIjG1KqrVocqOmStrTmNZP
         jK//xnxq4Gj1YVGIUhUC222VfIDWmQ37s4KglsjdH324e0Rue9802EMvRR6GVwc9NXyY
         lJeWfaLK4ThnjYD00slpHxKppa56s3xA15rsp8XCWUhWmYvlyp/FOlUtqCA/oQbzAc42
         syPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800048; x=1768404848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eO9EJ1SzMv+Xy0KnqPrEHfvHLOumowI49Qpx0L6iCR4=;
        b=FhqMZq+3aS7k4LjjJO2cmw6Fdj9VqTpHy1t3P1RZo8qSkN9hU4WYd1x+gBHq0eRmke
         otN6VsHMCWwvmo+WF1dS9oMSBdnlSca7YRMruR857vH0tWhPjz7V5KmhY1BpVFOwDy+F
         hfb274bGUya/+Tx6ND658IpWivKylLOreX0L+8seCucNkz67VWerwoEfjKuzD2b9DrEe
         JWBDfLwxXvSD5FbFL2DVMkq9FcXAZdAdd6vb/r/hFkPv8JKfmJ46hyU2d5cQl/dg3k/R
         J6lP6lcmqLecX+jWA1PtpFnjwYMoPK7QTgd2zA39gTaPFrtp6i2Fr0d0kEEOvV6tXxeW
         jxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOJ7kpNUZbgXTLp9OidPAXNDPUdhz6oXABmPQ3fpor4rC/EmAkEID8DgErtttTnZJxaGAtQVh1IIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqzziuCr7Ffn6qw+JnP8ORZBMnvgOZaZeaVAPX0AkKywjgKhk
	EtBpt4mDFu/INPNowPPlg65PiCw99J8h+wkAtHrNmEHzzefbj/L9JGnD
X-Gm-Gg: AY/fxX5SB6gR85HCiuvpS1Hq28+ycKhBiYaaGOcaoKMPXLcnStY5/Ai//qZfBhALmFW
	139Ws/Hx0vgBh1ww6dJt4qx5cr48E7YbXO6KZmBcN2yS7xdVavUAWfh3+uFQnhoKS/dTGuCB0af
	JCRDTenhvQ8yWgxGk3jcnE0jmDzlQKGiwzrZa+X+kTSWr6qdsKYNfImm4CYSMnXoFzcmChi62Bo
	yaqjn53T4yizfQ0wVSEeVeOyiwnxsriOcsMDrTs9uemfFGtfxaQKrMxbBGHJdxzaoULswdtUkvG
	eWeJ13QrOOnrOozgjEcoKV2trDq4c0toCbFGR24VwBsQOss2hi0R+mr+ay/E2n25xbI6rjebVOp
	45oji7+vIH275vc5c0ixTqK6iSfNAOtxEmVw72U0LxchUFmal+H23CUns1Ck3wOoycvu8FLbHdd
	tWY5DMsH7v7TiQie+XvUV3NBS1QLYtQ0ZrHueEX+gzXnC+
X-Google-Smtp-Source: AGHT+IGtCDu0G6eYH3g3wT1M6IKy3YB9HAJ3+3EJ/cXXN1DdsBvhXWe62M+fG6NKVgTW6NRYPp6OFA==
X-Received: by 2002:a05:6808:18aa:b0:450:32f0:4887 with SMTP id 5614622812f47-45a6bdfd28fmr1087090b6e.31.1767800047653;
        Wed, 07 Jan 2026 07:34:07 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.34.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:07 -0800 (PST)
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
Subject: [PATCH V3 09/21] famfs_fuse: magic.h: Add famfs magic numbers
Date: Wed,  7 Jan 2026 09:33:18 -0600
Message-ID: <20260107153332.64727-10-john@groves.net>
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

Famfs distinguishes between its on-media and in-memory superblocks. This
reserves the numbers, but they are only used by the user space
components of famfs.

Signed-off-by: John Groves <john@groves.net>
---
 include/uapi/linux/magic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 638ca21b7a90..712b097bf2a5 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -38,6 +38,8 @@
 #define OVERLAYFS_SUPER_MAGIC	0x794c7630
 #define FUSE_SUPER_MAGIC	0x65735546
 #define BCACHEFS_SUPER_MAGIC	0xca451a4e
+#define FAMFS_SUPER_MAGIC	0x87b282ff
+#define FAMFS_STATFS_MAGIC      0x87b282fd
 
 #define MINIX_SUPER_MAGIC	0x137F		/* minix v1 fs, 14 char names */
 #define MINIX_SUPER_MAGIC2	0x138F		/* minix v1 fs, 30 char names */
-- 
2.49.0

