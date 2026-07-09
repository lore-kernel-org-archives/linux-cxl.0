Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042B36F8E7
	for <linux-cxl@vger.kernel.org>; Thu,  9 Jul 2026 23:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638406; cv=none; b=Yh6jotYbw/Wy3mzQexzBfGmm8nh7FuHkpwYOo5Z0LuLxZFxmj98eQTq/TBqZCivpfUSYEQVVKzN83hvIv+a6EI6bSkUjpzC9rhbb1/EybzJeH6ne+WnU8V+BZFLsRjuycmoPGLn55E6u3mkrqqVRkpWruDHzGQvdPZN517mGKH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638406; c=relaxed/simple;
	bh=Nr20FWjG2NroNbXZwhjr1SjTV8yECc1KxfDUU9MIAqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haTm3ReCSIU9uNPBRyxVO5MyyNtktGgfL49akK3D6NMYT5ElvYxyx6p8xxs8gzQR0QzBDz+cjb66+GjNN8Zm2tdiSMUc6/aGVpV5o89BQRZiabl89kTYLFlM8RDWgp0H1rWsQpDY73ATbiM/wyjjtbgnSj/U3lE0GDBH+ccpGAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QFPJ0QaM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QFPJ0QaM"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92ea24a2dbfso23220985a.0
        for <linux-cxl@vger.kernel.org>; Thu, 09 Jul 2026 16:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1783638404; x=1784243204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G+I1Kh+neFzTKmOmQym2AfGZpWjdwKJKu5WX9LjuS6A=;
        b=QFPJ0QaM+jKDmbawT46PNA7NSUWM3GHu5Dt3+ThjlsbAtweovklcUWNS4npkS1zU6J
         Gb9vQ3RDvclrvCUwaEFG0UjsnsjtM0WQFNctTffzLQkfPRR1uqhH2hsnphY+kygwGSEV
         02KNN+Skz5mc6WxDH3IxsRCEzMB5M5KCFfwZuwIF6yXkaAdEnAe4hOYn4PZjJY41Lg3B
         yddNhJMmqP3KRURfQPiJXP5FpTH6MjbU4nmpgKJEnR9h0BzN9I07T35+zWly+Wu+UQW7
         Uk7ViFJk6wdA8Gi0TRDBp+9MaVtNAs0qlSUbg0QwD+zLp40l0HQ0eRXLRHzXaJ02LTOl
         dhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638404; x=1784243204;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G+I1Kh+neFzTKmOmQym2AfGZpWjdwKJKu5WX9LjuS6A=;
        b=WFAajSAy8TwsDHXaJxO10bHUfw+/rw7Mux9w26mSH6l8DnDAJPBGCtl0UWq+nqxEOV
         BgBQml1D6n4tHhuUuRY0X07Ip1m4z6w27mxK07wLlPmTU/YLKrNAreaDCQfPBYZZVjun
         yBTepOflTgZ9bmwnFo9sxz2TSckYCnvmrTYUeeENBCcxQuwSgnYsNW6T3oUOWfZE3Df7
         qIZRSbEv7lLTemf+GYznIZhe6Av+C2pgqVmhlRLoT7EbziiP5w2paonxO+8B75qlvDE+
         BrzV7AvW3V6rSiVXgffBYRhZuWEdXObw1EHwQg4Z/sUENs+kFWYuz4nrEo0ksB6mIuEN
         gBGg==
X-Forwarded-Encrypted: i=1; AHgh+Rob86WT4MJgKVL0jfAf8PXxEsX6jqVvNRuXvvNH7XQzQbhBeHxL0A0/GrKJ6jW2JiSRpeGZe/Nce/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2xYE5ILSBEK2VFQRAQQRoXemPj7bgQp6yKug0jKFmmQcZe+e4
	1qKGu+WOfN33Hs7er+C2aCqFatmqHQO/l6RyPv9fqFot2WjUPkyCNkcdp8H4xcc9tjg=
X-Gm-Gg: AfdE7cn0upBfkgN2X2vasjyOCFZ9zUH8SnltpPakUVVBXcY4DovJWsi2VemXmVm9sR4
	VwanGqqMsu2tEoh1ObIT/sLWIzubc+gHK4txMn/RV+ji+3AAznR28l0Jv76Tde60SC7J+xi1qid
	hE6orwsedLslyKnIz0oGx1zQRgGgcX1DaqUruXEnoXAMY+8F/zsp6rTCS2InbLjFfhEhiTHoT0s
	/ecDcQcR+OrONcOw0lBduwAL6t3N6n0r3VCO+TYGcsbI198IfvnCLBURBMdLEWz+xhzlgSzkZzV
	dg3GdvaeG0FzQmv2xNYF5ZDtlPJrBk7Vbt60HXco9vDTEW4xKx8FB/liDNzJFbadIteslYqHdiz
	zx3V67T2uS39Gl3R3/JZgNk4RWgAvVnTPWsSKosckfUWY5bAzdgcoF4bfoSdzYtEUxW9Od3VxeI
	aX/xyXEi36Gi3XBtDrFsElEm/qe01H7naMvdIu8YmL5Qqvm+6aLJJimKerTri5FatIM1/k
X-Received: by 2002:a05:620a:31aa:b0:92e:7db8:1e86 with SMTP id af79cd13be357-92ecf6aa487mr1099339185a.58.1783638403562;
        Thu, 09 Jul 2026 16:06:43 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b1bbsm59189185a.2.2026.07.09.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 16:06:42 -0700 (PDT)
Date: Thu, 9 Jul 2026 19:06:38 -0400
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
Message-ID: <alApfp2z9Thyan16@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-10-gourry@gourry.net>
 <6a502267b17cc_3b7ee51008f@djbw-dev.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a502267b17cc_3b7ee51008f@djbw-dev.notmuch>

On Thu, Jul 09, 2026 at 03:36:23PM -0700, Dan Williams (nvidia) wrote:
> Gregory Price wrote:
> > +	ranges = kmalloc_array(dev_dax->nr_range, sizeof(*ranges), GFP_KERNEL);
> 
> The new hotness is:
> 
> ranges = kmalloc_objs(*ranges, dev_dax->nr_range);
> 

ack.

> > +static ssize_t state_show(struct device *dev,
> > +			    struct device_attribute *attr, char *buf)
> > +{
> > +	struct dax_kmem_data *data = dev_get_drvdata(dev);
> > +	const char *state_str;
> > +
> > +	if (!data)
> > +		return -ENXIO;
> 
> Cannot happen with a dev_group attribute. If probe succeeds then drvdata
> is present. If probe fails, attribute never appears.
> 
> When unplugging, dev_groups are unregistered before drvdata is cleared.
> 

Ah good to know.  I am always paranoid, but i'll drop.

> > +
> > +	if (data->state == DAX_KMEM_UNPLUGGED)
> > +		state_str = "unplugged";
> > +	else
> > +		state_str = mhp_online_type_to_str(data->state);
> > +
> > +	return sysfs_emit(buf, "%s\n", state_str ?: "unknown");
> 
> So the "unknown" case does not need to be here.
>

mhp_online_type_to_str can technically return NULL, seems better to not
just let a NULL dereference sit latent even if we can visually tell it
can't happen today?

> > +	/* Always create blocks for backward compatibility, even if offline */
> 
> Unless maybe a driver knows better and wants to preclude the possibility
> of legacy per-block hotplug policy firing? I.e. driver asks for dax_kmem
> to start in the unplugged mode per my "should DAX_KMEM_UNPLUGGED be a
> online_type with a different sentinel".
> 

I suppose I can put DAX_KMEM_UNPLUGGED in the header and allow this.
That seems reasonable, and makes sense why to differentiate
DEFAULT/UNPLUGGED.

ack.

> > +	rc = device_create_file(dev, &dev_attr_state);
> > +	if (rc)
> > +		dev_warn(dev, "failed to create state sysfs entry\n");
> 
> Always prefer statically declared attributes. In this case an attribute
> that only appears while the driver is attached would be something like:
> 

ack.

> > -	success = dax_kmem_do_hotremove(dev_dax, data);
> > -	if (success < dev_dax->nr_range) {
> > -		dev_err(dev, "Hotplug regions stuck online until reboot\n");
> > +	if (dax_kmem_state_is_online(data->state)) {
> > +		dev_warn(dev, "Hotplug regions stuck online until reboot\n");
> 
> I like that the BUG() is avoided, but I think these should stay
> dev_err() given the severity.
> 

I had to go back to calling remove_memory() by default given different
feedback, but I think if anything I will just modify the BUG() to a
WARN() and call it a day.

ack on dev_err().

> > +	struct device *dev = &dev_dax->dev;
> > +
> > +	device_remove_file(dev, &dev_attr_state);
> > +
> 
> One less cleanup to do if the attribute is registered statically.
> Attributes are shutdown prior to this point.
> 

ack.

~Gregory
