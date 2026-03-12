Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96237379EEA
	for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 10:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311209; cv=pass; b=TFG0FwtgGFDa98IInPlh2pR84HBcJYxluG2suONr9V+yW0wFe37cbP/nIIWJgodhUFsZoxYKo+yMXEo+OXQtyWkFgjHl94K8I/GsBHW3cID+w20YqhOfXI3WQOKT5SKKbCsABvYUWa4DoqPv9oDPWCq4u77JrY5WMwj5GoC8vD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311209; c=relaxed/simple;
	bh=6eNMvBAN5fYzpCXRq6s+PRfaV095V0riQ9UfgTCrdok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDFwNb65MV1VaN5oPt/7Q69jQiEyp5B9WXPcIIQlDSMa35C9QDWN9k0TC17F2x9HtNkgdfLWCaDpPiue5JLAsC7JHAuI+1Vsl2NZu9aZKmtQHCjgaKHxxlSSBgygl4plsdPIz7+NMuKlGLkzctsE5mlYxjecH1bSuyDoeOUZ6jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPEvPjHx; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPEvPjHx"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82748257f5fso1130915b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 03:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773311208; cv=none;
        d=google.com; s=arc-20240605;
        b=lEP5mPVFDcKZ0Vypye+jgs7xQp039OH5uQU9tmOUNdBSj52afekVf8tzon7hF4Nzly
         iETGXFfLpYIC6k1s6+viU1szOEySamUhUSrGXuJr9wL7py8Z6hQNo+wwHD4BB/mMPXAY
         Levr6qw6YEk9F0R5jv6T3kM51PJIkKdpthxfNNZw4wOKRvXAQKg0P7gfU49vUNs40KbK
         Yh89gPJXU59M0W+N2yXHiXAow1tP2cZ+jQrZNWqHJj8rtVei/TiYvteVwH4G4Lo64QL/
         B3cmXSF0bMK53jA0wfdk5MYJgIfAKT5uG47hdQKdTj4qjga6i4qDtQ2epLlkbQxtQqnx
         8W1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XanPOnxY51YvsD0Ag7bQ6//A3PB5jw978tzRC78Dbxk=;
        fh=XX26uUhAsJq6iajZ5X4xvPUfCxIkDAIH7kV1XGUh7ys=;
        b=MUig4Vd3Oa+LmdQcrYyJmj4J4wsqQYGMYUuhV81Uvla6hsjwaMJizcHQkPKuGaK7nG
         HQZgdH/6mIEBQEP1QsyHKmGAwqiTPQjvGPb/rTijBy+sRxbkipChjRVW4c0yGmCMyt0P
         MzHH9QhnMmOQKmyFwVkfENQGmHlSwoxof2b3SJKFH0X3xl56STvx0cX49YB8ItSJOGoP
         AupLY2r9uMFTpdaJ07IJADJaBgRw0ZmlgxtrROS2PRpslTaZ1kmCBEh2Ef4iPKhjf6o5
         wQbR2sTR7WX3SoOOcDwu2izwwfutUJ6gjBcFoBDusHNaGBJOXtxl9logw/I8ufGA8F36
         tuCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773311208; x=1773916008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XanPOnxY51YvsD0Ag7bQ6//A3PB5jw978tzRC78Dbxk=;
        b=OPEvPjHxhIOq0LlG2YHscmqBBl873xZ2HvnUwnOvfoCwj8TurYK0kTPqmcPVuJutGF
         H5JtnTLCLTCxXLZq2Q8lXBY52u2wP1qd59bywuB+mm2BxjUTD/jLGgFBCImmYf9CQwgi
         U6MeRCg0YsgGGyWIxHPRy/lDCV2mP4kBByl/xYeupF+YOFnD1ckDeD6jmDL6TegDWqM8
         rhCpsNI1VXKdP6/OJvH6pvQIieD7CHDRltkj8zQ4YkOjRwKV3VDIH0OFur8UL/2rJNia
         AaA9qv0YG5ffS8RmC00hpx3lsBvzdtqeRSAiIAISsoljpqlPgjUlr8vXc44t+35EJMMR
         griw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773311208; x=1773916008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XanPOnxY51YvsD0Ag7bQ6//A3PB5jw978tzRC78Dbxk=;
        b=DcnaWcyWnzqWcdd9UjQMj8uK5cUwl8hIYqq6/bgVw4KiHxYM5gFRrkLhdvx/EfUrpW
         JNWuGn98e6J6XFGYbdUdtgNqLIsNJTAQwzorrl6xuWsib/C87+t82fY1hiOcIAmZn1um
         JB0YAuQlocRLHhmHyJ/JQXYGox8Ht3VmPD02t1wCIpNsYqpnRprOdgAasP5FUEv+/em4
         92f2IewG0RI3AApztbYg5cbRhYCIU8Mj5bZ7mD/RwB0K5JKZRxOt0Y+SQ88Wf030JoE6
         XpIIbG0nJrRLep5FwWYjEhf+eGt9p0R4KMV10DzAzzS9NXbB/0OzuXJbeNq2wv4Op3er
         AI4w==
X-Forwarded-Encrypted: i=1; AJvYcCVhYI6P8SOK8LbLYluBHyHFG1GEoQeYXTldcIDkxT/h/j6c1nA8q4i2SSHHZZ49LmvJYbi2n7ZmvUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/GMhRjoORjajjAnRigZnTaf94G5nJFYbt8N0VMnXz0P18h+c
	b6+IEJGrCSdhh/e/uWQ0Uo70Y3IlZQZXVqM+Pm2CaHby6ZtwmI2cmnbX1JQ1uk5469l75xJMLKs
	GmhkUwKSP5oPuqoiYpJsETJnI1j+RXHQ=
X-Gm-Gg: ATEYQzxUU+EQ5a0sWe++t+/OFrzHKEQcAOgqE1zcjBFXfjmTahU+QW23xoDCecp7x54
	gpyhkpnU1cXtj1qc/dJTKtuH/EvwnqzeNjwot7wU8qf9DjadyGCnSA3QyNHrTFF20pQy1bXNoqM
	Mljck/dTE6uHL8rnXnxIXCj8opCdouk6tEtxuIu8pLZ4DSfuqON8gPtdgT5kgf5+46tM+QvkCuP
	kOTd/VIcYVHYhAsBZ5jMs0TQ1XSX8GihxzK3URkEBOAlctTsWCNJPx3mn5lNoG+JodAlAhNymGy
	Ckex7vsOsA==
X-Received: by 2002:a05:6a00:c90:b0:827:26b6:c11f with SMTP id
 d2e1a72fcca58-82a072febb1mr2946528b3a.31.1773311207770; Thu, 12 Mar 2026
 03:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312091207.2016518-1-seven.yi.lee@gmail.com> <878qbxpeoa.fsf@DESKTOP-5N7EMDA>
In-Reply-To: <878qbxpeoa.fsf@DESKTOP-5N7EMDA>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Thu, 12 Mar 2026 18:26:10 +0800
X-Gm-Features: AaiRm50bQAC-fpj8JCT4o2RRLkW5gPS8IrWtPocoCdZLLPZoUx5KKkT0m0xLzPI
Message-ID: <CALX8JfTEEXWNVJdDGK_rDCQQc4swR1ApyShUPYX4U69rVzUosw@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node bandwidth
To: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, david@kernel.org, dan.j.williams@intel.com, 
	linux-mm@kvack.org, joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org, dave.jiang@intel.com
Content-Type: text/plain; charset="UTF-8"

> How to use this new interface?  Can you provide an example?

Hi Ying,
A quick example:

1. Check current (original) bandwidth
cd /sys/kernel/mm/mempolicy/weighted_interleave
$ cat bw_node*
20000(MB/s)
10000(MB/s)
0

2. Check current interleave weights
$ cat node*
21
10
1

3. Override a node's bandwidth
$ echo 10000 > bw_node2

4. After override, check results:
$ cat bw_node*
20000(MB/s)
10000(MB/s)
10000(MB/s)

$ cat node*
2
1
1
