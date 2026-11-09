Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243791;
	b=Gxj4FoFKKkFaDQe419bXbNm0df+E/JQtyGR19v1ZG215Xn1pIsSTOp8CxWSTsvWQNLgq
	 XlBQf7efZiQ5+7JzdKInkiYID29i0TAmrsjZd6rR1Dt0DdClbi2vfEIJYH9Q0VU+1pqcy
	 3WDCP0wVMKxeEkNZsllxnVB/dDc06O4hgod7EwpEnNx4U+PJW9vh89wie1Pnqhj7PL6PJ
	 tFsEyd5tGBj5WFL9wzw0K4Wuti1TcfXFxm8KkpTeOXW1xJxGFdRjp7bWVsdsLuRs2SLub
	 EQwmAP3ucjE2OD0iHiR/PdG1f/IzRlTg1GXLOUI4JVFCwiwQUaPjkVwN8cgbfa0NKTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type;
	bh=EiCyFmyHns/6JeMiTgX99ZP7gU78wmi52w0Se9KfmH8=;
	b=26pheXT391ebGXcItPC36lyobCs8JMfGWufNQgmiZG9lLQTYV0vT+ZLclYdfZnX77Esw
	 v2eticajjou5Wn4l6PKnfVhTrWbstT8Hd3mycIk7af17yipF0zei5rqwFN2iqhI764onH
	 xK9vRorir/bYO3+fx8kNTOGMaQtIUIJnIoiyzB9C/uba/+aJKdrz5H5AAQnPxeGt+PI1D
	 uMr1pt3YMsQBLTz769PF5sYm2VC4xh7pet7Uq//3xWXpGJ67sVpIi7QXIGs3xFRYWD+bC
	 QHsnFORncWuO0rmiWoxBhqG55gjNwX9yuLvX5Od8TlIgSSrp5/ybV5IRud046hB9enA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FJdMA1jF;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D51606A326
	for <linux-cxl@vger.kernel.org>; Mon,  9 Nov 2026 17:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20D51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=FJdMA1jF
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so52255ad.1
        for <linux-cxl@vger.kernel.org>; Mon, 09 Nov 2026 09:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794243790; x=1794848590; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EiCyFmyHns/6JeMiTgX99ZP7gU78wmi52w0Se9KfmH8=;
        b=FJdMA1jFbsghxBHVEhFuLvPfG7Rcq9WdjYJWBNR3mkYokvGp4YJAk+TgNqNe94tbGs
         1a/l2fdyVUigVqrPxfN7ZoGH0MwKDyAc2tzAzluz8c9w42bW6WlWDhLaueP8HtImoRaH
         h6y1al0CxqcD/Bk7F2oRsOBNHJZoxLuHVsrz3zt3mOt+TQ6SYJfCTdfzq7GlcB76Z7n0
         QW0YPXL49LS/uGmUWsBJCa7ZTOvMZh2M4dH8bK4y7q0XCotghVLFJTgUgP5uA6vUAb7m
         VZDgK1osV5EJHXUwm5vbt2nU0Wwn2njYJ4hSZ/xcgwXl1r2W1PZBcHh18U1VCinxavi8
         MCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243790; x=1794848590;
        h=content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EiCyFmyHns/6JeMiTgX99ZP7gU78wmi52w0Se9KfmH8=;
        b=bzi+z41+wtiA0Di3EjFCmZSqZix9NBQRJdav5Xcm5F7K7XRHeze3AvPsWG2RDeS3+B
         UAFxveAadWtb3SGdHrl7i9Nm72Yv03VLCMvRG7itqyN6CFGUqo0ptECVBjhNQcjQHGgp
         5hIQUCIxRkU4GHpu4Qa4fPqQbDSN86vcoNreMuCoyi4wkgCtDNvFuXEptI0mI7HwcEzi
         AxOU/RtmtVxR7841FjJlGuH1c8fbEVj19VpJEZt9pfuZ1xsmR+In2uSaeEHXI3KrvHP/
         RkX7zXpsSSKQ3boTOsQUmRE76em6GpR5QrOO+8VOeZRgu3sT8qksqLCJqmJkt1Es5nPr
         XC+w==
X-Forwarded-Encrypted: i=1; AL+hErE9td9zs2aEE8QUbSKrh1yPHw/JF6xlE+wI8maVuK5/KL14yDm/bekysLQi7pKSUu04L+oFvDtMF9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aIfbeDM0cyBpk3KCvZdGjZRqgx/gEjvH5AHpMFzEP+WEUrg7w
	aiy1TjZwQ8h4PhuLBSx4TB729WNhZ+1TPDh3Lqo/Yg+kPBl7cyGb201gzRcfnXnc0g==
X-Gm-Gg: AYBFou3FYcivjuBPLBO1WUKFN/HEzTU0HBPctcv5nGj5tdqrDlJ0qA6NMnd5ND+U6/i
	KY3GJWS2D4C4GpnOCUo0+mmnAeA2qI6ALigdH1PD4OFLNmVUkdL3qqLueIwwWaiO0p3JV6an3rH
	BVuaswdI3+GCJJXklcYyTawHk6JwUJW1wFurLhWQN0NBgA+RbAHxWHO+P49IfnflInuK9/ByAtC
	vnSQZZ7dW+PRmQasIoWfId8rCczPcIab0EPGNsl4ATNH0HzeiItmYLEhEVXKUuHJjx6KZffasr+
	21dw7FN+bLga3khOdkVXwNyvO+sx3sThqRvNzmcU7/Kkb7h2d7MAu1qtr72qC4MWJOr/KwnckFW
	LOpcRZwA8w2ymKOC6fEZ1qxlxpFG16jerogeTmfo4ySgTJTC1Tq3Lgk+3tq8ks1PhaYzb94tCaM
	xdKRs/4tt4afmWPJw8PKmlqWTyA6k3vA/om+0PvDPwQIQX6hjqfzEBZkk3ylpgKGJJdEfDjgDpB
	nk3s4No/1sUrCFzfuTaK/PfvvuV1E1v15tIky+oI6EIqVeDU3BXP3jBHqDwyhGHIWk4Qcf6Hyc5
	BZTQMgf8PgWnNmHcBzXuKP7UXHfkRLMmgZ5cVCge5sr308VU64oNGa5GOqE9oifvgk8xlIHLBf3
	lb4z/kTNR8Ogia6Ysozr3mvd7VcbtCPedMgqCH/xYR5JEaZzU8ZyCSYukLcFcomOIkJdrwGoo4D
	BQ2clQaOtlG1V8C/nqlyUeYuQj1CBXTLGLGkqKHH1be1vm
X-Received: by 2002:a17:902:cf0d:b0:2e7:e742:8bb5 with SMTP id d9443c01a7336-2edb6ef6dc6mr223335ad.14.1794243789717;
        Mon, 09 Nov 2026 09:03:09 -0800 (PST)
Received: from [2a00:79e0:2eb4:9:d9d8:521f:5a01:aae5] ([2a00:79e0:2eb4:9:d9d8:521f:5a01:aae5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16769b589sm179496a91.5.2026.11.09.09.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:03:09 -0800 (PST)
Date: Mon, 9 Nov 2026 09:03:07 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Amit Shah <amit@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
    Aneesh Kumar <AneeshKumar.KizhakeVeetil@arm.com>, 
    Christoph Lameter <christoph@gentwo.org>, 
    Dave Hansen <dave.hansen@intel.com>, David Hildenbrand <david@kernel.org>, 
    Davidlohr Bueso <dave@stgolabs.net>, Harry Yoo <harry@kernel.org>, 
    Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
    John Hubbard <jhubbard@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, 
    Joshua Hahn <joshua.hahnjy@gmail.com>, 
    Kirill Shutemov <k.shutemov@gmail.com>, 
    Matthew Wilcox <willy@infradead.org>, Mel Gorman <mel.gorman@gmail.com>, 
    Michal Hocko <mhocko@suse.com>, Mike Rapoport <mike.rapoport@gmail.com>, 
    Peter Xu <peterx@redhat.com>, Raghavendra K T <rkodsara@amd.com>, 
    "Rao, Bharata Bhasker" <bharata@amd.com>, Rik van Riel <riel@surriel.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Shivank Garg <shivankg@amd.com>, 
    Sterling Alexander <stalexan@redhat.com>, 
    Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>, 
    Vlastimil Babka <vbabka@kernel.org>, Yang Shi <shy828301@gmail.com>, 
    Zi Yan <ziy@nvidia.com>, Gregory Price <gourry@gourry.net>, 
    balbirs@nvidia.com, apopple@nvidia.com, matthew.brost@intel.com, 
    liam@infradead.org, alison.schofield@intel.com, osandov@osandov.com, 
    osalvador@suse.de, ying.huang@linux.alibaba.com, baohua@kernel.org, 
    tj@kernel.org, jgg@ziepe.ca, baolin.wang@linux.alibaba.com, 
    npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
    lance.yang@linux.dev, usama.arif@linux.dev, muchun.song@linux.dev
cc: linux-mm@kvack.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [Invitation] Linux MM Alignment Session on Private Nodes and CRAM
 on Wednesday
Message-ID: <4b2a7250-ee0d-74ed-2301-ca2f8f30f850@google.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi everybody,

NOTE!!  Due to Daylight Savings Time ending, the time in your area may 
have changed.  Please see the list of times at the end of this email.

We host a biweekly series, the Linux MM Alignment Session, on Wednesdays.
We'd like to invite MM developers to attend and will announce the topic
for the next instance on the Monday prior to the next meeting.

Our next Linux MM Alignment Session is scheduled for Wednesday.  The
details:

Wednesday, November 11 * 9:00 - 10:00am PST (UTC-8)
https://meet.google.com/csb-wcds-xya
backup: https://tel.meet/csb-wcds-xya?pin=1301132214803
doc:
https://docs.google.com/document/d/1QQfZFPHa-pGEGf4A06cSqS0jdJwuZ8ro9JU5H0YSUQ0/view

This week's topic will be Private Nodes and Compressed RAM (CRAM) led by 
Gregory Price.

If anybody has ideas for future topics, please let me know and I'll try to 
organize them.  We'd love to have volunteers to lead future topics as well 
as requests for MM topics to be presented.

Looking forward to seeing all of you on Wednesday!

Time zones

PST (UTC-8)		9:00am
MST (UTC-7)		10:00am
CST (UTC-6)		11:00am
EST (UTC-5)		12:00pm
Rio de Janeiro (UTC-3)	2:00pm
London (UTC)		5:00pm
Berlin (UTC+1)		6:00pm
Moscow (UTC+3)		8:00pm
Dubai (UTC+4)		9:00pm
Mumbai (UTC+5:30)	10:30pm
Singapore (UTC+8)	1:00am Thursday
Beijing (UTC+8)		1:00am Thursday
Tokyo (UTC+9)		2:00am Thursday
Sydney (UTC+11)		4:00am Thursday
Auckland (UTC+13)	6:00am Thursday
