Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AC63246F4
	for <linux-cxl@vger.kernel.org>; Mon, 17 Aug 2026 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786942351; cv=none; b=psdQWzsMxUL+RDSFbx1CdsdSvSNFzKQ2RrvFQ2Z8S3+nSuI0qvfHi+5ZYMuNTPtv+spcU3NF5xs3BBUXDMhLBNj1Ov9LpOHT5NT+ZV5PeA0Q3PlgXFHM7b7f4jXpB3S4SyCxoKJdsufs2Bsi4F1RK56Wcwcnh8R7rDKeEJUgU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786942351; c=relaxed/simple;
	bh=GJRSgVBGJeat3wAEG8z33jEB2lg7XxYymKLeUaKrn1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2PhFraMuXSI2n1Nkxire+A/ebvfCSWCxEUS4ds/gL3CaIsnidvrvpxwGQaBDAitivSCRi8Fp8+UQpOywZbnjxQNN3YML74rTaJBtWL+uqTl7zDZ6wvwX1CFo9YF7LgVKc9asb9lN1CGsQbrx11cH1E36koWIplw7OAQNc+rIc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk5TnM7v; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk5TnM7v"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-448b69cfc6dso1989599fac.3
        for <linux-cxl@vger.kernel.org>; Sun, 16 Aug 2026 21:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786942348; x=1787547148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXCFBr15COi95qp1EsFgIG/0N/CfzI8VoEXN2Vn844Q=;
        b=hk5TnM7vJi48bgkZp8C8UGtaIg3aAhfbYnpJd8t1LK/UFAS3+hgue1LH0iPkopwDbl
         8iT9qXI2n8G5tA6QsfI61DfcnSs7Wm9DpQO0ae6YVeXXzM6WVGVXBT3VKg0V/WFN5jc+
         ANY6C8QLO8/j8r6D+PllAxVccNZ+jPB9NF0UfCnnT7fOYRHnjgDj9fBEuKHPsn1XQgE+
         pamdrcdumW1yvp2/EeLWloYQS0Aa99a64Hykk8xWadtTl4ie/XGQr250kYnW9qBM+nHD
         7x282a5FlCHpCRXisRit/B7XyB5EQdBrAK8ZGT+lwt8k9pSav9ti5WZtbaUYcLmNf7Vd
         Yivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786942348; x=1787547148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXCFBr15COi95qp1EsFgIG/0N/CfzI8VoEXN2Vn844Q=;
        b=kS6rQSJJfG2JU2KCmdYh/NxUCZnRp54EII5Csxozfj7kxiyMeo54HfePxlEQO8olYS
         Mdb5yxasYVw/oDsogyEDgZQtBL8s9VLrFs56hZAhOUq7cmkP0dp2uVfC68Vpc1YGlzvi
         fzk4A7d32DM/2FXJgB0iGqH71WbPPwGFc0VgNH34Jev2oyPRME63qouU4JJhcYQI66NE
         JNsMsiVB46/tRQC8GkqzWOeHtsl1R5u7C3TgtfoNGRwTq+XLfxVMS6DbES7wcYmU1Aqd
         ym26OEdVYKecOX8BMF/OcjP8m46BNu9iIQuGs8WNy68o3km59UuSdElvuERLdLml8hMu
         7b/g==
X-Forwarded-Encrypted: i=1; AHgh+Rr6DCpIl1z741pQFw6cX4CudtKm2fnOShjcGCPbdkpXsah9REHR+Fc6AE+a65n4cOhAwd4iGi7P1Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMt4xppd38Utxal4ev7hqIS9haRmQvGUs8CZ+jl+mQtfq2P8x9
	XTIffwKWoV6t/pZhENmFURV5nxW80Ee+lCUlIYov7abJzG7LO+co/qxQ
X-Gm-Gg: AR+sD13vo8pgBfOhLsi2gqdExoMIy0ETg+uFqQAgTyeckX2ar7DF60nVh4VL8eXfAh0
	Cb+8KFM9cYJyFOSyMUZUeGvvjKqDcXqMYbG5VmYCBUqKM/IlW/LrQr/XaWHAvftNlfupzgAoLqK
	WCtpEL+TU6XIaOh/L42NdmAOhxH4paM8P+2jhB57pwpvkuHaknklD2pLZacz9P/w6v63myJvfwT
	dJMulcz7YP+CNWD4zPgN7X24g2NPDyAQC3HqhbocQG3RfLQ7MqCRslEknnw1W1Lxq+6iOtMxid9
	HKIG9BRLQ7WATxeKb5BiOHilfGcU0biEkJmjZcczE0tF2vvxd3sUpwljEd4J4//WDT23Ua+YPUn
	BmausZHGkrX6uVx6r2Jqos1/RgzUChHG7BPm+WSuYWuYtHw4D2SK/EkP0Gf5Rpz7nUdJVhJAFVr
	lQPSfpUPCA64CeAgAjHbnUqbZ7Xir8FIhoPGI5WYT5B3k4mVidV0Rs7RXVTsGJDVY+BstNANyxZ
	9PNXZ8zGSpBPOvI1lxkqUlWAVmcRzbENQ==
X-Received: by 2002:a05:6871:680c:b0:448:c6ce:9617 with SMTP id 586e51a60fabf-45e91ce96b6mr18797832fac.5.1786942348251;
        Sun, 16 Aug 2026 21:52:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:a::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45f22aea368sm300381fac.5.2026.08.16.21.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 21:52:27 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Gregory Price <gourry@gourry.net>
Cc: Rakie Kim <rakie.kim@sk.com>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	byungchul@sk.com,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	harry@kernel.org,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: introduce package-aware weighted interleave
Date: Sun, 16 Aug 2026 21:52:24 -0700
Message-ID: <20260817045225.1807518-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aoJY53BJztPQYumw@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 16 Aug 2026 20:46:16 -0400 Gregory Price <gourry@gourry.net> wrote:

> On Thu, Aug 13, 2026 at 03:23:48PM +0900, Rakie Kim wrote:
> > On Wed, 12 Aug 2026 22:37:06 -0400 Gregory Price <gourry@gourry.net> wrote:
> > 
> > The cpuset.mems = 0,2 you describe is the node set of package 0, so
> > the tasks in that cgroup use node0 and node2 wherever they run.
> > 
> 
> I think you are over-complicating the explanation and that's making it
> hard for folks to reason about this.
> 
> My best understanding here is for multi-socket systems, weighted
> interleave as-designed is inherently sub-optimal for scaled workloads
> that utilize multi-socket ("package") memory resources (DRAM, CXL...)

I was thinking about this and I think Gregory is right here.

I wonder how much of the framing around this series can be preserved /
simplified if we just say "prevent tasks from allocating memory
cross-socket".

I also wonder if instead of limiting this to weighted interleave,
this can sit on top of other mpols and just nodemasks against
cross-socket nodes.

> I think there is also an assumption that total memory utilization is
> less than the total capacity - otherwise some of the assumptions here
> break, but that comes with the general weighted interleave story.
> 
> I'm getting back from vacation, I will take a closer look this week.

I am also out on vacation this week : -)
I'll take a closer look along with the code next week as well.

Thanks, Rakie and Gregory!
Joshua
