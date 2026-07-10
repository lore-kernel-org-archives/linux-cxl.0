Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E8362133
	for <linux-cxl@vger.kernel.org>; Fri, 10 Jul 2026 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783652937; cv=none; b=YpQ/BVoaJU8i7oOH9KRT7iEMSYyMTtU6zJokAqWkDO2oGrucQsz6MOBW0SGT1lqPgQXB1N+G+DbAZCgZQQmcWqa4NWUXLucF9k9DOjdgN/lVG0S6Ufwn2RD7JqB4xXOjHuOzVBe/VpVdiQQlyV8gh+wPKbtAF4GCririW7dcc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783652937; c=relaxed/simple;
	bh=le65lxpxw4W65xyZzPtwOptaX/haFn4+aLgX+gVQMQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sytaF4EIOuWTjS768LxZR4QHI/Ha7d764ybJMYqtqkQfo2NDtu+EzL40lfIw5ioo+mEnC67IkzTPZI7dJag+l1EldMpd9MzoioiBD74QxiQbl9fh/sbUmCFMSM6cSWYhjRcDHQr1i41cd9KdKg000F8Xo639BzEUE8jhcXKeqQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=jcERSOnt; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="jcERSOnt"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e54f8c051so19416085a.3
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783652935; x=1784257735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kr6wGBD9MJbLbiRkKQ9M+EqleUNYFT/q4nJmIpqWguM=;
        b=jcERSOntAvY0mbE1/LrlTqzFn5l/R7t2JgCYQpnQtdvKPJq2mL8kvFPCncxlENRBrX
         oI49UXprOlX1T3TWwNAIka1OFzYXBp6H100E+j02gq1NjyzZ3mi+j+FUxz6h8aiO7Jgr
         SoDovlnOpT2zT6j9/D2C4Ydg8PO+DcVHiCTKXgpDBAvhvRFqn1m0l2DB02VzrYlUUNTm
         oD4bZplTjKF90vAabyz6+16lg3hcjQQ0GhrzNY0Xt4hSt80P8yU539hE94lM1CrTj475
         vIGyH2FEexmQnDFEOX62D0if6xTyFhP2eOBxB+XGbQ9QEDT0c8FgSvcUwm3l1Q8LwY0K
         psww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783652935; x=1784257735;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kr6wGBD9MJbLbiRkKQ9M+EqleUNYFT/q4nJmIpqWguM=;
        b=hhbncYuk4LT4/WOutZ0qbt0PT/KP4MrGQVzQCh1AdRHP1z6gdiN5GaYOk1xlEZU74y
         3bZrg5rjVl7T3W04jeCf/ichbxGJ/6cxpGkA4RjustCt01jTAlkPO47WSblikRZH/iGk
         vVD/RQRt0w4aD5ac1lt/s9P9M6eJPmwTtNc3U9LyVkdvQLaIvTv4zxDbNERmwpsp/7CF
         7CosA6mc1v3oulgN7KGejL/0G43Gx8W4VnQ2lpn+TQM/Mdb69wOMhJLOJ8RgVJHZtSgp
         SVraPY5SShWhNr1CvS67S+HrgkKV0xe1Zp3MwiOTlOGtmtS4H+xpbZDT/nSFd/p/jy/2
         Ramg==
X-Forwarded-Encrypted: i=1; AHgh+RrN4m5V0a09MrGwe402/k08M5kF2KQ7fSK8oQIUJh4W8vK8xKbkw1+BILROz51W6dol2a9ANWu4dGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUePFqASuO3STlTxTQV4rBvFQLmujuCKVcs4oU989kY9p6GpEk
	v+uV8bB7YcwLlCzbWRTb/sr4PLUmwURopQ5GykJSlmn/iInYIJV2EATRmffKWGH380g=
X-Gm-Gg: AfdE7clH0iH5knc/84m1x0cIYZA0AseSVQNRMsi/S/kOfMkFwr+LG4oHH7p8QMujEzq
	icS569KIuwFsp3/j5VvIRaYS/oHkmcLPIS+PuefvM2+TilXhWQ7uMYkm8EA7ycPvQrc1hRyRmEa
	mrW1OcjzQXIhRw9gV1Zx3PRWcLR9QcYzvhyIfqwq3QpbJ2Qguz4tMno87x17VFLx5NzZY1zj9Od
	ybUnlxBhhTXcDjaFyvcPf+goYhunwInexcXL5sCBSXx/nXcg9/rRUofWPH3vmYSMBLQkeg54qa7
	O+KARhBRr2kW8OLStFNicgQKpGCCMn4uGzkRIA1xlWtnGOqrbq8p9v9US+cieNJ3caMj7O4iIuk
	wfzfVIt8TBJCIyz1ZFcDeRajZlVtdm0DwHmA/DeU5BfeXosHlunTTw2hjHgAZlzGqpNOZSVHXKF
	F4oCRnvaIQpUrQUttLAA0D8JUUej2BEO2YVS2H4SmM7VhmyYemBSm3qyRmFrfZyfbfSpSuozEQv
	Q85kBc=
X-Received: by 2002:a05:620a:2701:b0:915:eec4:49ab with SMTP id af79cd13be357-92ecf5dd3bdmr1127366485a.51.1783652934221;
        Thu, 09 Jul 2026 20:08:54 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf78a5sm97038385a.31.2026.07.09.20.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:08:53 -0700 (PDT)
Date: Thu, 9 Jul 2026 23:08:48 -0400
From: Gregory Price <gourry@gourry.net>
To: "Dan Williams (nvidia)" <djbw@kernel.org>
Cc: linux-mm@kvack.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kselftest@vger.kernel.org,
	kernel-team@meta.com, david@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 09/10] dax/kmem: add sysfs interface for atomic
 whole-device hotplug
Message-ID: <alBiQArmsWFg975w@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-10-gourry@gourry.net>
 <6a502267b17cc_3b7ee51008f@djbw-dev.notmuch>
 <alApfp2z9Thyan16@gourry-fedora-PF4VCD3F>
 <6a50356aa7a4a_3cabcb1008a@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a50356aa7a4a_3cabcb1008a@djbw-dev.notmuch>

On Thu, Jul 09, 2026 at 04:57:30PM -0700, Dan Williams (nvidia) wrote:
> Gregory Price wrote:
> > > So the "unknown" case does not need to be here.
> > >
> > 
> > mhp_online_type_to_str can technically return NULL, seems better to not
> > just let a NULL dereference sit latent even if we can visually tell it
> > can't happen today?
> 
> Oh, makes sense I was thinking "unknown" was only a result of the
> drvdata missing case.
> 
> > > > +	if (dax_kmem_state_is_online(data->state)) {
> > > > +		dev_warn(dev, "Hotplug regions stuck online until reboot\n");
> > > 
> > > I like that the BUG() is avoided, but I think these should stay
> > > dev_err() given the severity.
> > > 
> > 
> > I had to go back to calling remove_memory() by default given different
> > feedback, but I think if anything I will just modify the BUG() to a
> > WARN() and call it a day.
> 
> ack.

Ah, you know, on second look - DAX could never reach this BUG() in the
first place.  I think this was a hold-over from when i was originally
refactoring and trying to figure out the right path.

If there's a desire to soften these BUG() to WARN(), i can submit that
separately, but i will close this all out with some comment updates.
