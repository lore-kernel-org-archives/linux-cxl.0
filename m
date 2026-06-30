Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2343437DEA2
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804315; cv=none; b=WXUuI0Yjn1vR2djmlwCcz9IPcquh8KwMGNy3fTVLx8L3bbkWJwsFouycoVOBmBIdFha/paS0GT0CfC6xJ7MLr3YmQg7MUX6/H2L3xPrFp4H7oYjwn3aMoBokoHaQ1I04EzZPjrkeDlLlAb2fRhIvvKsSBrFA3YagLVQcImMFpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804315; c=relaxed/simple;
	bh=LXjwGtnES6N1Kc9ABDRgfM1xnVQrZ9A6GsoyVrwU4No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XKPMCRyGYVU1fXTBfOGeNY1Hgmk6sKVapVT+2bJhWSkHIjEXuBZI3hpTE7QXlvphh5xmIiZ2xyfovtvOSbLfI4rtaaYVN1HMCqH2F64LHKsPWHTxWErrDcMCM9H+ZXL5WB2a398J3RMb1qyoV/Bq/OS3e1ZbSs1kUob1TmFwdeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WSCQhUeK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSCQhUeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782804313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T8IRfAFAOswM/FHwO19+KBl7CbCbKiUJMFkwpdewsoE=;
	b=WSCQhUeKhoJzC6uGDUx3RlsNWurcoQ3xzlrn7bn+oEO2W84nqT1YA7cmUl6YvfMcWAPWQ/
	zN1EKrO0GD7wGmFo/IiQoTutL+sABAYDyOFof8bHwyrxIdTazOwhrNP+EyxYZorEGNYf7e
	JEBbr6zca/CVYwJPmnsN2akTzfcSG0E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-Hgt1AqBeNn2eTPbzZ4zP6A-1; Tue, 30 Jun 2026 03:25:11 -0400
X-MC-Unique: Hgt1AqBeNn2eTPbzZ4zP6A-1
X-Mimecast-MFC-AGG-ID: Hgt1AqBeNn2eTPbzZ4zP6A_1782804310
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47485fde05aso763086f8f.0
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 00:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782804310; x=1783409110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8IRfAFAOswM/FHwO19+KBl7CbCbKiUJMFkwpdewsoE=;
        b=f14okOYOpAa9Gen7WVHF8eT2wDM02xzrNjYYWjeVQoWjrOhji4y1YSwQ5rU02m+0eT
         QUEzsjTVJkcHLazTjeXK7YRY78iv/oNgvDQz+rlGDrx/RdgVnvJrHMVbttsmIHDMkcWc
         rywDGoq2zL3k8EXEzIIDF3d7lDWXgG0ZS8VGh2Ss5Emv64/vYupQ0IoT4HY1UbNasoAt
         qzqyVCFg2vMcZ3QIeNiUC8pXPZKqxOfHFWeJbvXk5XEnUfMirtbhAlEPIFTd3uk6lCKR
         zZUn2ciCwjGRB8DcoXkXeXFaPajME7bbL1XGJdNsF806hwz/rGtxM+e0eewnLYLdRGAJ
         vrQg==
X-Forwarded-Encrypted: i=1; AHgh+RosHrieI/8NMWGNxV7GpiLK6HGBSsR+emNCYEitLFHl6oW0h1VjNjT9gLcK6zM93qh02vEqV1Gg0sk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweca4hf1fjEUO4GJ5mgrqP9qG0ptB3rRB2DOFQZobIQ8imHTPv
	g6zME8hxo/A7e9JmbAvJs3x11gDQWtRgqXZ85W51dJG4Rk9d7FfUBAUUuDEPcRLgJYmsQ/BV+7R
	fa+XE1kP8XD5awYvw1HDc5rYnOIl+VP4Lrx6G2pnxT+xDcjLc7VKZznXxbmTU1g==
X-Gm-Gg: AfdE7cmIDAUiifLzu5QFVNczkCuvSJWVWuzN30RX4dBX9yfFiwqi3p1Up1X2zHhnng1
	SEtD+uemQgV7FVhH3w5PU7qh58hPDSlGk6OVcH8xT8CwDWECG1/p5YZH7a84y6b/zEVdfT2xhDV
	c4qTD/PKhm6lDcGyIp+Llo5bWmWhHkHgPN69e+bCA8egEg8mK55z1wxmZfI9swfMbGD1GK616eV
	jr1IV+gXFlN+69RQa9VK8O6VgA7G7JNr6UZ2N2uoMJBuL20M6DO4rHB/k0F9abjZ7Z0BwO9hJTA
	1wu7ZFP6SFZVPAsM0E/2RoLc15Z+cqyffExLev9RWc8CdS/7zS6H50Ft5Xn3IHhc6T7reTpBh3T
	F9Q==
X-Received: by 2002:a05:6000:27db:10b0:460:2ee5:67b8 with SMTP id ffacd0b85a97d-47552a67f7bmr2268123f8f.36.1782804310042;
        Tue, 30 Jun 2026 00:25:10 -0700 (PDT)
X-Received: by 2002:a05:6000:27db:10b0:460:2ee5:67b8 with SMTP id ffacd0b85a97d-47552a67f7bmr2268047f8f.36.1782804309448;
        Tue, 30 Jun 2026 00:25:09 -0700 (PDT)
Received: from redhat.com ([31.187.78.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47563e0eee5sm5074622f8f.5.2026.06.30.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 00:25:07 -0700 (PDT)
Date: Tue, 30 Jun 2026 03:25:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <20260630032001-mutt-send-email-mst@kernel.org>
References: <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
 <0a309ed3-378e-4d88-95a0-65bf47c5496d@kernel.org>
 <20260629193347-mutt-send-email-mst@kernel.org>
 <5c8ca96b-381a-4fd3-a218-6aaa87a9a3b7@kernel.org>
 <20260630022129-mutt-send-email-mst@kernel.org>
 <0fb36931-9097-43db-98bb-d087b7b0fa12@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0fb36931-9097-43db-98bb-d087b7b0fa12@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GVsAHLCN--u_xIqF0geBoUcXHAUXK2FP9gTvtpw1R3M_1782804310
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2026 at 08:34:44AM +0200, David Hildenbrand (Arm) wrote:
> On 6/30/26 08:27, Michael S. Tsirkin wrote:
> > On Tue, Jun 30, 2026 at 08:17:42AM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/30/26 01:34, Michael S. Tsirkin wrote:
> >>>
> >>> Wait a sec, what about call_rcu_tasks? Use that and re-check the bit is
> >>> still set?
> >>
> >> So, in essence the idea I had yestarday when it was late was the following:
> >>
> >> Assume we
> >>
> >> 1) Can have a way to guarantee that a function on a CPU cannot execute within
> >> our critical section (while updating the flags)
> >>
> >> 2) We can request to execute a function on each CPU and wait for completion
> >>
> >> I think we could just let each CPU execute our desired action (e.g., try setting
> >> the bit).
> >>
> >> E.g.,
> >>
> >> 	local_irq_save(flags);
> >> 	page->flags &= whatever;
> >> 	local_irq_restore(flags);
> >>
> >> And assume we want to set the bit, do a
> >>
> >> 	SetPageHWPoison(page);
> >> 	smp_call_function(set_hwpoison_smp_sync, page, 1);
> >>
> >> whereby
> >>
> >> 	static void set_hwpoison_smp_sync(void *info)
> >> 	{
> >> 		SetPageHWPoison(page);
> >> 	}
> >>
> >>
> >> The idea is (that needs double checking) that a CPU will execute the
> >> SetPageHWPoison() either before the local_irq_save() or after the
> >> local_irq_restore(). So it's own non-atomic update cannot get interrupted.
> >>
> >> Now, IIUC when it comes to "how expensive is this" I think we have (cheap to
> >> expensive):
> >>
> >> 1) preempt_disable()
> >> 2) rcu_read_lock()
> >> 3) local_irq_save()
> >>
> >>
> >> So the above wouldn't be better than an rcu-based approach we have right now.
> >> We'd need something that relies on disabled preemption only.
> >>
> >> Huh, but I read that "anything that disables preemption also marks an RCU-sched
> >> read-side critical section including preempt_disable() and preempt_enable()".
> >>
> >> So for our use case we should be able to use preempt_disable() instead of
> >> local_irq_save(). That should already work for your existing implementation.
> >>
> >> -- 
> >> Cheers,
> >>
> >> David
> > 
> > We have:
> > 
> > #else /* #ifdef CONFIG_PREEMPT_RCU */
> > 
> > 
> > static inline void __rcu_read_lock(void)
> > {
> >         preempt_disable();
> > }
> > 
> > ...
> > 
> > 
> > static __always_inline void rcu_read_lock(void)
> >         __acquires_shared(RCU)
> > {
> >         __rcu_read_lock();
> >         __acquire_shared(RCU);
> >         rcu_lock_acquire(&rcu_lock_map);
> >         RCU_LOCKDEP_WARN(!rcu_is_watching(),
> >                          "rcu_read_lock() used illegally while idle");
> > }
> > 
> > 
> > 
> > So on non-debug build witout CONFIG_PREEMPT_RCU (what I tested), rcu_lock
> > is exactly same as preempt_disable.  It's relatively cheap but not free.
> > 
> > 
> > preempt_disable is not going to be cheaper.
> 
> Well, it will be cheaper in the general case (CONFIG_PREEMPT_RCU) :)
> 
> But yes, not for this case.
> 
> > 
> > I can test if you want but it seems clear.
> > 
> 
> If you measured only !CONFIG_PREEMPT_RCU, then yes, it won't change a thing for
> that scenario.
> 
> > 
> > But IIUC task rcu might be cheaper - IIUC it does not need rcu
> > lock/unlock at all, it relies on readers to invoke the scheduler
> > instead.
> > No?
> 
> I thought that still requires protection of sorts (preempt_disable /
> rcu_read_lock), because it might fire whenever the task is preempted?

Why do you think so?

From Documentation/RCU/Design/Requirements/Requirements.rst


Note well that involuntary context switches are *not* Tasks-RCU quiescent
states.  After all, in preemptible kernels, a task executing code in a
trampoline might be preempted.  In this case, the Tasks-RCU grace period
clearly cannot end until that task resumes and its execution leaves that
trampoline. 



-- 
MST

