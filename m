Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8399213B5BA
	for <linux-cxl@vger.kernel.org>; Thu, 11 Apr 2024 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816694; cv=none; b=njFTLEIAK/x+R2jPbXaz3O8EEAkBxc5HhmClu4LpQ4W3Yqd8qljt7OczLw8mM1pKdRMW0S+WrUt80IaiC1P7+pMkZIPv1tiXGrvydhCH4oPJRy2mHldvIUGaIUxlqlWFjCHtxq3rXwsar31FOFzLTsRExX4TTsNxiLfj6HCbcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816694; c=relaxed/simple;
	bh=444uiMQcMJzHmI0zrEsPgMSi/MBOOaGCll154shiDkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JoUPHiJI/jjDlN0VXeScqO731hi7ECvQWIBwa4N8XioE3jAbQ4buxAvz2zpunbAN18mRUW0T5w7kmlJgIvfCzquNKd4H4qDhgZnzKelHrWvq8rsVpQbkYVs6ZtATRF8J9RY6HZWa/3RQL7yUsDmlrLqSCjN9piI0+0YXAmNz0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzgyPoIv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzgyPoIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712816691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RCX6MGp3mzAjan9U+6PijABpgY0GU571g8JyE/O/vz8=;
	b=FzgyPoIvlIicyHKuRlHmxjwM5a6u4SYUjRg6PDGAhqvjHUDba2GWOYNXNJdC4/+3SILLi8
	gek3F30qCBCaLnqfjtoiBEL1w0HYchB8Z3EoL6l7ucTvi37uZ5yZNR3wv1P9ujJhVAoO8V
	X7Tlgy0MzFdC8+RfMV3AHcTqxABm7Bo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-s8PqL6tjMzOkE1bJBLtX5A-1; Thu, 11 Apr 2024 02:24:49 -0400
X-MC-Unique: s8PqL6tjMzOkE1bJBLtX5A-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-56e2b417c6aso2456378a12.2
        for <linux-cxl@vger.kernel.org>; Wed, 10 Apr 2024 23:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816688; x=1713421488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RCX6MGp3mzAjan9U+6PijABpgY0GU571g8JyE/O/vz8=;
        b=eL35X6iErrOtALKnwW1kcJUfA0xvyVX/8xYD7Dfs7U9cVyRURi8yhLSt8WegeBjj+B
         vIO12AW3cuCl9/ZmPA1i/aUkkdhI/2fCQYkhgK18uujDEKU5Bs7nDRUmCs2ryZ3nYvC5
         lqx9drELqmBDWno6B1VxBj162LfmMVHEKmECsn1P2vJZObK+LNVJeeiYrJkNODUobGz5
         eAr7+sTlNjSmVHB09nqoKr3ZYArZF4sWLPs/bvr4yHVWAcGXcJEwQE5FUCm89BOxrdA+
         xQMaHv9KTzidBjNupCCHu0Zu3q6NHDbyWf+HkXKMI+n1P5OoOlW28jC7FsY/wvvLKdWB
         5PUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFL/u6NAwugnzpxGQ7t2SOsvYODRSajtzI4hCdB3iLQzx8yK2uqmrQGwILYkTJOUxqU7xrwMG2Rvva8MdtPVNhaJN1qqdXN2DI
X-Gm-Message-State: AOJu0YyUAOYxFmKSTuKDykTB+55XOrKPKh9s/Y3skmALTvOrQ/SJt2bM
	c1RF1aUl0i8+MyTXKZJ35uPUDEi1O4YPPEhUW1rytS6nTdg/n+0N1OV/PTEtJy595MCGy0FcZ5l
	NDgicPVRg1YrJy6vDOlA4FQYDBL3X+fyOBpuXjsdyM7/Qwz9ke20R1ruxog==
X-Received: by 2002:a50:a69b:0:b0:56d:eef4:28f0 with SMTP id e27-20020a50a69b000000b0056deef428f0mr3980162edc.20.1712816688787;
        Wed, 10 Apr 2024 23:24:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnVcBcnrTAav1zdTHrQ+F/XWt8yZqNhgddppdiT7mQ7vHwUi/Ryaz0cR396KTlvaukyg8GrQ==
X-Received: by 2002:a50:a69b:0:b0:56d:eef4:28f0 with SMTP id e27-20020a50a69b000000b0056deef428f0mr3980147edc.20.1712816688397;
        Wed, 10 Apr 2024 23:24:48 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id z21-20020a05640235d500b0056e718795f8sm379123edc.36.2024.04.10.23.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:24:47 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: repair file entry in COMPUTE EXPRESS LINK
Date: Thu, 11 Apr 2024 08:24:43 +0200
Message-ID: <20240411062443.47372-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Commit 12fb28ea6b1c ("EINJ: Add CXL error type support") adds the header
file include/linux/einj-cxl.h, but then adds a file entry with cxl-einj.h
(note the swapping of words) to the COMPUTE EXPRESS LINK (CXL) section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair the file entry in COMPUTE EXPRESS LINK (CXL).

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index edf6176a5530..03204db05027 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5415,7 +5415,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-cxl@vger.kernel.org
 S:	Maintained
 F:	drivers/cxl/
-F:	include/linux/cxl-einj.h
+F:	include/linux/einj-cxl.h
 F:	include/linux/cxl-event.h
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
-- 
2.44.0

