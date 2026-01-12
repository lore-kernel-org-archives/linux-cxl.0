Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BF8290DBB
	for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768261605; cv=none; b=meCMSglI1D9GEHVaVo3L3Qo9eAR0R8Um4FjIgAqqsFlgGG22HIY/ulbCe+rKvZBXPAc3TF6MsJXxbk5CvzBNFYny7NXKtgB6OC/O+1JOA8oZCjIUxz+7cv7Q/cSfnEZjCYVnOUHtAtJvrBnlfdILHPRHDv7DGn0ninKNgboafiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768261605; c=relaxed/simple;
	bh=5jG1tPSFDGwVGx2fOLIQipqpQEiX+dEX85OrETf90AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhZRYkmrhyln2i8rJOTzU1IyU4pQQyPULzzdUpopHuZUJQNfowPHAszqp/ZHya3VgAZ2pzv3Am5WpVruTJC9//mYIl+2PHquQvG/nHa5+rf1oWJ1KP1Bg8uZAypr6LiF02Tm7hCfoVyW6uQRNSsKwt0nViwRdW+3KOfrfc1N5bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UqrI3UXZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UqrI3UXZ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee1e18fb37so65765381cf.0
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jan 2026 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768261602; x=1768866402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gt/AVyATGJCjg02bpOukDf7tzsy1q7kJHO83Jx5UbtM=;
        b=UqrI3UXZq9jAXv6AFYXS1jPHxOz9ewGQA8y/stLlNbNV9iUNJ+mb0ITRzwskUwjQl3
         zzmhIwF1yzveIyS8MMn6GmV4ARtFZC9rwwX5EtGET03q0MoVw3gNE+6w4xYC8vxfCAaJ
         a+UYFs6Ckh8iEA7QGPDbkIIY/M7Rqkcbzu4Xb3Q1lhalmBRJa/adzrx+B22XVr8EPk28
         5SwYZWvDs0LY9mIvF+D79H7buzUESwxckaePaOddHcbxOk1v4A/+5uakVrG/h2WXPjuI
         lL8Mu+gv83BqBWgIkBfjuKYWlX7fuNYDSpG4qTcCB9x31panvpFGPhLAyiVZh6i2MTsJ
         QesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768261602; x=1768866402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt/AVyATGJCjg02bpOukDf7tzsy1q7kJHO83Jx5UbtM=;
        b=WNYKpfBMBt4DwvieekZ04P+n3SS9bSX10C8ks0fTlmQoX6bv+8KQcNfXWUmfHUS70R
         i+cDMVTskvAz+JqwzjmaOZt6aOLvRoxDO4fDg1fXHfZ4oAzqrHwkfy7YBMdbcKjfLfEj
         eIvtEw5fyfZj3CWVzUEN0D0oONveinvYfVfU1Qp3o/D5sRd4ffEoDE3hV3dzp4Ab82wA
         KHsC0yW1xox7kF/bx46E6Vr/I/rbkU3wcNruhW83H4Lt3jm5jjmRGcvN3+y23mGP6Nqb
         IwAVgjzrOTTDtazjtfMYbqfQISslJyh1XMFMActshf8D4uqzNG5OtV00kJWzANlNcmYX
         KKAg==
X-Forwarded-Encrypted: i=1; AJvYcCW9x1lzV0BoPEwUx1v5ZmXSE+2NydQZZJXzsWIA2zTwaacsfO/Fjb8IqMswgv0i2+rD+9R/gpP2Zu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYSe724mGsrUF5oJcnvEOiaCbJQFVq96Guozo2QWVmzcfKp8ga
	9clIgfh0rps1zhewL5Y8IQxpoTtimWJUDWNZhF6BhQAz8V1KsWm87IBurlt8MHz4Znw=
X-Gm-Gg: AY/fxX5MmOFiRJXTVhIbsAPCfmZQu5Boqs/Z75wWPDGdh0wgvRvNVKf4xy/pyG2e2jf
	Ar0W3v7xpVRQZaHeiTcJxO0rURQQI4tJ0trl0VnSDKCFWRv1XhBAXKA+mzxpcfuSPsMxnOv0FJC
	aYqX07hZKnFkVT729wjVPLz57F31/2k8RUIaiW/oqW6S25G9sip+/rynJdoFWWA5+WC/vnE/MJA
	YmeZlMFCH3tyhbwN+KU92wSSYSSb11UWYBMsEk2dCDQB97+un3CSb673blTKye1QpBLNBY5Hw/0
	QX5jCmWuH7gt844/gqQP47+Y6XpulalCulFmG8HE29skCFBeFclpbXwoVmmjXHa/fs1j3y9L6t/
	XAOS7mgfdDG+NZGMDo/0BypmEhHC+Ti2qp4hrk0NwXLk+NvAve1A9nzoROC+ng5kwYt3GqVqlu2
	Bg7s/O1NkTf0IL6x079kMG3RIXK9Rbd+pM8OGVRHp889RZid0LoPhyNuhpDO7IVuGEFXkGmA==
X-Google-Smtp-Source: AGHT+IGFud8YvEm7ATsxYNdlgRbfkjm9D9grRrxO3octkolx4kKDFiysT5UJJvHSioxVBl6DqcPzKQ==
X-Received: by 2002:a05:622a:34b:b0:4f0:5dd:c963 with SMTP id d75a77b69052e-4ffb484a53amr283188541cf.7.1768261602494;
        Mon, 12 Jan 2026 15:46:42 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d3d92esm136264811cf.5.2026.01.12.15.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:46:41 -0800 (PST)
Date: Mon, 12 Jan 2026 18:46:07 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWWHv-G6cZAiQZJY@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
 <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
 <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>

On Mon, Jan 12, 2026 at 06:33:16PM -0500, Gregory Price wrote:
> One of the assumptions you have in zswap is that there's some known
> REAL chunk of memory X-GB, and the compression ratio dictates that you
> get to cram more than X-GB of data in there.
> 
> This device flips that on its head.  It lies to the system and says
> there's X-GB, and you can only actually use a fraction of it in the
> worst case - and in the best case you use all of it.
> 
> So in that sense, zswap has "infinite upside" (if you're infinitely
> compressible), whereas this device has "limited upside" (node capacity).
> 
> That changes how you account for things entirely, and that's why
> entry->length always has to be PAGE_SIZE.  Even if the device can tell
> us the real size, i'm not sure how useful that is - you still have to
> charge for an entire `struct page`.
> 
> Time for a good long :think:
> 


hmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm

now that i have written this out, I wonder if the answer here is for the
zswap_node controller (cxl driver or whatever) to detect high memory
usage and online a new memory block if there is additional capacity
available.

This would look like the swap file increasing in size dynamically,
which is *also* problematic, but it's at least in the same ballpark.

From a CXL perspective, this would look like a dynamic capacity device.

And the catch would be that we would need the opposite interface:

  zswap.c or cram.c would need an explicit evict interface to allow
  capacity to be offlined if the device needs to shrink the "fake"
  capacity in response to shrinking compression ratios.

Time for a much, much longer :think:

~Gregory
