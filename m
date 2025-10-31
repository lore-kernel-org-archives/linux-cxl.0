Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB08D223DDA
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 13:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918162; cv=none; b=jWBHmjZyZRahbPfxWjAabEB4okkQBdt8aPTx43Oi7KCp6QMTWsg69/26VIF69so62rsXEvRO/jK5bAL+7SEE2w0Q2+I8R47pkz8350Xhv8i5oq1T+0ihyQYDWIB4k2A2zuY/STeBK9TOouaghvJom8lomoutkIW5mVZ+iIxTao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918162; c=relaxed/simple;
	bh=2EuZPp6iiAor3qSHhoxp+TV6FSvUxVrS44tAjEFif+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmWFAG1aJ5EzMyOCCM1YByud0+VafiDnve+V7lMemdDT8rhT7jNGCeXXAL2JwCgkel/Pzcdx5D08QCSIycao7qHMSKgAWYF5FGzonol9OOIsHzpwdzJypvx/xlpoPHLB3JpxnHXGtRz4ajlJLacVJkwgSmevXusBDWLSCKlRtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Xi4h1bhi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Xi4h1bhi"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8a074e50b41so283120885a.3
        for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 06:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761918160; x=1762522960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=njpOP5qLjsmm+goYm8hA16YQgCyFH9JxfoHaSdz75Hs=;
        b=Xi4h1bhi12i0XcniD1+4ZhCWSnwuPBhQV8funvVYqLLKAVBGGO/bsuv3ogUTbZqHUY
         CdFk3GzHrmFwdZx8WuCSPAm8GFi62NU66G9+bhSyHXAJAJd9OtiJjHZgCtpO5RzJD8zG
         7ibCAFRhR6TvrFxU1GkzBVirk3/thsyYaAcyid7H8QdXpNCsaHWBgaZIOlshZnBk1Lu1
         QPVWpl3wpC/MZ1YKj0vD9Bv59wYufKRLkgl/qVBmouzV5dKYDnBJ8K+37f/G2mzdRKHu
         3JT5rB0ErR5h3gWE8uDPYIcOftaOBZyB+sxPdDf0uNk3skioEq58AmxQatN5w1C9nAio
         +7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761918160; x=1762522960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njpOP5qLjsmm+goYm8hA16YQgCyFH9JxfoHaSdz75Hs=;
        b=mvLPUUKEPt3hJWmmFs8XzK0OcYlLeeQ909Gv2WAYwEVBm3n6j1Vhx32IMiEBos/GC8
         mzsGlXf/f3qGS6BtypiImS/lhvZrYe2OxhTzdvGloEp26JJikihLTYRAW5BN9149M3D+
         fEJ2Z5hrs3LEGX29K3NBUWtbTJZubSmG27J/xoBy4tqzEGbvQF7wLkYy55QiYuGBIgF8
         QvyRJgsRUR1ZndOZ9tfS+Nyve9/pvChhQwqqy8u7o2Bt9enfqoX6HojF5aJJnkQkijie
         AiDewTLRUdbVdDJDxzSwrXIHV4CrYkPOvI469V/v7DgMSI7EtyT+WBKwQ7Ai/p9cGByU
         FXjg==
X-Forwarded-Encrypted: i=1; AJvYcCWH38aRndaYqouxkfUYEZZ13duxKFYTk6VLhVJ24ph0PaN9PECaykPiMiDxHzuKpld0w3T/mVqt5OU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvU/IBO0eTuDPY0ldmJwFeaEb3gXnTPcBavUhYfQYoKnvzogKp
	LAZ+vNeMryMO0sZvovFbyN4py+5GWugLsmN+LfHeXbR5e/HGX6jRe/SHHxLlsKWgdwQ=
X-Gm-Gg: ASbGncuUw7TxwC85d3HCqTyfy8jxNDeV+QNkq+/0dOrKq60ulFi4BWhWMztDysgcaYT
	tf/QTtaOUPrEoLaYZdnNbdZg7nb9lWSBGN9/sL03D0fDKfRapXgh8vqHrFDz8PbcyPIpUM24xj6
	FzeYeaeiLf8Jx8JWAR+NJDn6u2qScjfF2+mePkZFEQTkFysjnvlv1QYValtSuKRtGqdduJ8B85I
	zaO9MDROaFia54cuhrp0td/5o3qUT5ohTyXe6hC+g5pBebxQjk39cBn0pBp2QPeSQl1YTCP1dXS
	F5aDayWYmPvODAJXhTO3zcUkRczISiXMoEeCaCDAg5AlmO+V9YGhajKMwGcmgNleDCo/tF4GNEx
	VhLLTcB+G9M4tZJ3SB2La5Wo+xGT27OcBDRQQJ1H69yg6k9HHTYXeDLUTxOp/Pim0gUt4Rr7xs5
	hlArBeVjXwwPIl9hE08yniHIbADacjU01j9JTH/nRf9zVUKaiWsiuHHsn7ygo=
X-Google-Smtp-Source: AGHT+IGI8y8YIPM3S6yMnHOJ6VxcbdkbS8NWxjTOpRsE5kmW+ZuRWtwB9gd6TlqHaKBjY4fr8ejo4g==
X-Received: by 2002:a05:620a:28cc:b0:89f:3fa9:d2d4 with SMTP id af79cd13be357-8ab98eba4e2mr437021985a.15.1761918159702;
        Fri, 31 Oct 2025 06:42:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac00a9a851sm111552085a.20.2025.10.31.06.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:42:39 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:42:36 -0400
From: Gregory Price <gourry@gourry.net>
To: kernel test robot <lkp@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, oe-kbuild-all@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] cxl/region: Support multi-level interleaving with
 smaller granularities for lower levels
Message-ID: <aQS8zJ4p-r5iSgd1@gourry-fedora-PF4VCD3F>
References: <20251028094754.72816-1-rrichter@amd.com>
 <202510311413.HdTizWHK-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510311413.HdTizWHK-lkp@intel.com>

On Fri, Oct 31, 2025 at 03:03:10PM +0800, kernel test robot wrote:
> Hi Robert,
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> ERROR: modpost: "__udivdi3" [drivers/cxl/core/cxl_core.ko] undefined!
> 

IIRC this happens when you do 64-bit division because it's annoying and
complicated. Ran into this madness in mempolicy.

~Gregory
