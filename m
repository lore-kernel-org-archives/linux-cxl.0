Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5F264A9D
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432558; cv=none; b=JO+W2/DRUF8yzxlj3suswdJPhR4bQRNpN+qzwik0XI1R2YgGBKIjlD6O1kIUDixwesX/q/A/Tyz0STFVtPUHrsKhtQdeBVWPqXt/F2/eDC0l1Jh8uwAC5tR8HbaJ/20fo0Z2qAGO/C1IwXiPqQovIrpmB2krjPrMGjoEqOMM4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432558; c=relaxed/simple;
	bh=zG2TyLnXjDP5W7454KU8fBzg3dWWFM4U6U41q0cfD0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTMzPab5XCKkDTQXtE9TVu2ok5sS4K7mCA9Z0MjAaubNF8tq7Z0l8IJkI0znY0cjTE4bzTdXnY+mZAajgS7n8BUgU+eivy2ntaEsc+x+/ZtjDL60RB5UjXUeeRqnBo/IvvXQlmw/pQIQ279GdtpJpBnoCUIwdgTyXKpFn/4uiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAbPKG/r; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAbPKG/r"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5014600ad12so2315481cf.2
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 15:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768432556; x=1769037356; darn=vger.kernel.org;
        h=content-transfer-encoding:libfuse:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUX1Xqe9Ih33TiO90xcxWEJ1pXhMadrkogKYy+yJV2U=;
        b=bAbPKG/rtIiIM2GYo1Q0eicuNAuxFYOqEjLQbw5fBp0i7GgI2snlxKZWOMvl9jwu73
         gLz1Q14/EeH/M551pV0kfuo2fPMzyEXtf3kk2/jndCh4+yGio/kVivkfboeVdNx3bJdk
         hnrjsB0Y9Xpee7uNvZxNm08Am96eCKkD0bPyH1+Qani0ylLqHTyaCmP3ERS1YHjyM10I
         hd3gPpd4K4rBA4H/AX0O/enopyIu4uuy797ZqKYOJcffYUmH/plscFwTYz8z8gIkTxa8
         nzjfvdXgEl9FzTT2LhR0L/xGZ+j1sKj86b4X7KhtLZeURl8ZWq+pnFQmbvVVn5EJcIX7
         3C5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768432556; x=1769037356;
        h=content-transfer-encoding:libfuse:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUX1Xqe9Ih33TiO90xcxWEJ1pXhMadrkogKYy+yJV2U=;
        b=N1YNt24AWNejShxMRmQLfkfgzDzklkx8c76Y+snRFisCbWo5XAtm7KDz9NpklDsz/L
         vJHACCsoFcMn3m8yY2VOFgDaVuVlajdJuS+xU9o0mW4Tasy2De1KSc986cCAEn6eegxe
         3H7w1StVwpxtt2YyPcTiXdpJXrFR78JnbWYVdFthSqFEiRk42nzXU1MuRI2KyiqnxUzh
         OS4d5qC00tbv9TxMLBmHH9byeIGATQ/LZ96QCg14GCOCPZ9NIjFUMXDLJlmlWbEOeC1I
         6bTFlLu85h/cMAlavHkPOrd7Sy6K09KONVRDEyxg1b96qXLy7U7JIpay983q+xUZz8OB
         UUNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGLmvlv0h2Ln4sIoSdOn9WE+TERjtE3CT1jSxRY3Gt88FAleLrKK9hm/QsULUPmls4TFnenVlHrI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1FzSzqaYCa8Oy6ZVlFAVMW68/kVxci5B01CUrrB0jbk/jS+x
	EUMqoqBsCvZJ3ReZ2pmrbkDxo6OeBFAcSLswb5nnzNIUsIzkzdY1I612iP1naw==
X-Gm-Gg: AY/fxX6Z6lyN7YQZ+L3BY66a5lN6tEffHm3gEl1t7szpHCdrDYD3I4vm2kzRaCNxCU+
	pFBsVJf7WTYIv+8T/MhIGF/0YmZlQ7xRkvazDyQL4GWN5w5iktB1gbXjGab3XL8BT3Q1LO9WDbm
	CM8BzKWYABKOYY2+RjVTFCjjeBaM49po8lVxIp5cncn47eVRxGcM9KHwbHhmq3UIiN6k0PzXrfX
	hE16uyGc73/LK1syjFPHAUEEm2ccOGGRsPA6MKXM7aDXhO5+gfo1G99Tn2/Fu3U8a1OXDkWc4u0
	eskJ6ClhTfA5MVEHKqkMD3hn+AwcMe83muikmWeW2vTfWFmLqhdo4vozQ8OMUOWEkEQwHV7M0hL
	BZ+Ro2cupivD9Fv9UdKJgvIVqFYJlKlkzZGcJBShf43aG3i/DugQmWyFvcWWSXZPMW7rtVvaqpB
	rHYxuEvQEihymCvY4N0sTYY9SoxVt9Gevnx8shfWPzRGTl
X-Received: by 2002:a05:6808:f8a:b0:450:d833:6bb6 with SMTP id 5614622812f47-45c73d65f1amr2396599b6e.30.1768426990473;
        Wed, 14 Jan 2026 13:43:10 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:4c85:2962:e438:72c4])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e1b0779sm11316868b6e.7.2026.01.14.13.43.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Jan 2026 13:43:10 -0800 (PST)
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
Subject: [PATCH V4 0/3]
Date: Wed, 14 Jan 2026 15:43:04 -0600
Message-ID: <20260114214307.29893-1-john@groves.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114153133.29420.compound@groves.net>
References: <20260114153133.29420.compound@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
libfuse: add basic famfs support to libfuse
Content-Transfer-Encoding: 8bit

This short series adds adds the necessary support for famfs to libfuse.

This series is also a pull request at [1].

Changes since V3:
- The patch "add API to set kernel mount options" has been dropped. I found
  a way to accomplish the same thing via getxattr.

References

[1] - https://github.com/libfuse/libfuse/pull/1414


John Groves (3):
  fuse_kernel.h: bring up to baseline 6.19
  fuse_kernel.h: add famfs DAX fmap protocol definitions
  fuse: add famfs DAX fmap support

 include/fuse_common.h   |  5 +++
 include/fuse_kernel.h   | 98 ++++++++++++++++++++++++++++++++++++++++-
 include/fuse_lowlevel.h | 37 ++++++++++++++++
 lib/fuse_lowlevel.c     | 31 ++++++++++++-
 patch/maintainers.txt   |  0
 5 files changed, 169 insertions(+), 2 deletions(-)
 create mode 100644 patch/maintainers.txt


base-commit: 6278995cca991978abd25ebb2c20ebd3fc9e8a13
-- 
2.52.0

