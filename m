Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9FE34164B
	for <linux-cxl@vger.kernel.org>; Wed,  7 Jan 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807332; cv=none; b=cjh7qhBp5g7oc4Kk6HVN1+cyKztiMgalWIaLIv47dmXV5q4O02MUAYtaUKDbtf5X9Pn7rJqtKrmUJIs9dBsTPOypM5i242HlBhPt2oaXq3wY8/6PobJt4lkagvOFDicffMkprj4l3Us9oixNWqDH4A5nj4b25Fzf27g0g9w9Knc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807332; c=relaxed/simple;
	bh=JZb4un39BlPP+OGm49xPg22uNlLarYMy/HsntlA1Vg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft+xUdbh9YBoWxusIFhxo4biYjMXu49Ooytb2uiZI8FXYtl6L22egM+BarYr/oLCKRXXUIU/5Hrc8V1aK4VozRbGp4Ms0zupMnkhI86VJDo7If8ZrJeoOnYO4n+z19Y+SfbW7U31Vv/jcb6TtFZ7H9QECOd5mreKKnt17azwccg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBuGQcBt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBuGQcBt"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f1bc40b35so28299865ad.2
        for <linux-cxl@vger.kernel.org>; Wed, 07 Jan 2026 09:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767807330; x=1768412130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txgoLEmMjHER+EBzHDKZOrkZdUQtWotXYsSwAupxNQg=;
        b=YBuGQcBtTKHkdGoSsSQfROawhzW5Lfa1axoLwUoOu4+ineF1WJ1XNvf/3/EKdo1KV4
         cJfvKBaUjwAbX3IqN54QTwH5qoLJoXlk379eN8pJk7f0nI/B4a6EHn7enuu0oQJ4GqAq
         q0l2HMzARyeBOW5OX56AUmDiulouZY3Yb36EsS2bA6luqg6qUYl6xfgU5P+ISiCa6iXT
         NebWCWqd1UwoLYVVXdb6mfUIGHKAaCsCxUYxDarvLPI9Jr/Kfi6fVeNXQKsOiB8mPoFz
         BraNVCGmRzPjU0AkJWNnRp/KvTpB5I+MVBeNPTWpxAhVM6V8FrQ8AJinfzoPIWtfz+Ix
         wnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807330; x=1768412130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txgoLEmMjHER+EBzHDKZOrkZdUQtWotXYsSwAupxNQg=;
        b=upnlIyfZ9AiPhtjTfKfp06+L8aUYXu35pVjXAvoe9BplEMYJoUdkQgrdzIXggwO8Ca
         0BcinvM1ighNJsWI00EhlxtbeHYub1bVpq87JFp+tjI1KOdxdNfSFn+Dq7iiExeUGAck
         Dv3KiRkCfj9h4qTPapp+lMnaGG7VmrqgiHE7SUd/H9yzv69+9M6Ek7Wsklcv6iiuY71I
         k9vkgwF1waMXyqILGjt4kOPOOGae2AQjq+qjl8GaITGd1u10yjggXJ90+2hssNii60xA
         N2E7oREP/4TrGRPFBWhEUeMpiX5dKi5P5PL9Azw1z6mCfBhcKsPBRbfFN99qmjvzMhFh
         fkUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsvgdM5VrvKmN+1kFZv/s46HBtJsAGVQpjqpER9fFK3m1aGGFYKEv96qrOpPWdi9cgm4/6cCTO10Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJK1rOBgOBoxM39vFLutQnFrq64KRZNkz+3z+conz1/ZEeju8f
	PK2IIEZEVq/y2sDnOVV6v/CA4wH4dCPVLne2AEq6VuK3JVLiSU70+/eOKTQKoQ==
X-Gm-Gg: AY/fxX7V6femG8bFV7mjpiJYpGW9vx8Ch5KOZTxvX4DjF8GtCBC1OapnbX0jk9UJXC9
	uCQyTZtP/Cu4cLFivrr+hH0Te9KdPuefUmpCC6QIBhSVSLJ3QLDjVR3vaZZQ6KygXEbyVf0zufi
	1BjoX/pZyU7MyXNb1QxfVqLcyQ+eYrGgDTs7gvXoL5jVEMWG+wtjuKykPVDzBsPOTmga4Hr8/Ii
	lqmZfBj5XqEJhvEWPYScxEbbud4M4+aeze1803RhQYVUgnhigY8UYvVC8I3Ul9OZcb+Wk0ro87R
	VXKmo1mXFwS7/ZW+zoLuW74/cBvzBPUjzHnkaUIPAgi/Mc4HwUjVFobNhy5ixPRCc1L3M4DNcJ6
	ZpTK0QK8B1IQEdQ03sA4sUkuhJ5HbJ06YtnLr3lwu9hpXtNglUI7BtX3hkRGnbSbuS6taZYChAS
	s/7ZIdjjoWlpP8ZGsvrz8fTJ4AaNy7/9bBNO9TdKGwP4Gj
X-Google-Smtp-Source: AGHT+IFI7aw5Hflr3Zesdi0nYazb40KN8jZ7mrRBERbvb07PBqlelReQ+seRv6/V7wYnwshvoEme0w==
X-Received: by 2002:a05:6808:144e:b0:450:b14:7a6a with SMTP id 5614622812f47-45a6bef2392mr1217539b6e.60.1767800088459;
        Wed, 07 Jan 2026 07:34:48 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e183ac3sm2398424b6e.4.2026.01.07.07.34.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:34:48 -0800 (PST)
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
Subject: [PATCH V3 0/4] libfuse: add basic famfs support to libfuse
Date: Wed,  7 Jan 2026 09:34:39 -0600
Message-ID: <20260107153443.64794-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153244.64703-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This short series adds adds the necessary support for famfs to libfuse.

This series is also a pull request at [1].

References

[1] - https://github.com/libfuse/libfuse/pull/1414


John Groves (4):
  fuse_kernel.h: bring up to baseline 6.19
  fuse_kernel.h: add famfs DAX fmap protocol definitions
  fuse: add API to set kernel mount options
  fuse: add famfs DAX fmap support

 include/fuse_common.h   |  5 +++
 include/fuse_kernel.h   | 98 ++++++++++++++++++++++++++++++++++++++++-
 include/fuse_lowlevel.h | 47 ++++++++++++++++++++
 lib/fuse_i.h            |  1 +
 lib/fuse_lowlevel.c     | 36 ++++++++++++++-
 lib/fuse_versionscript  |  1 +
 lib/mount.c             |  8 ++++
 7 files changed, 194 insertions(+), 2 deletions(-)


base-commit: 6278995cca991978abd25ebb2c20ebd3fc9e8a13
-- 
2.49.0

