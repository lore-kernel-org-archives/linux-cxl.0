Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1E30275E
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 21:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769808657; cv=none; b=attpUf8rWKATI6dkvSWAQHu9Y9fuvLCxfB/ILSAMlmi+PKK5oG+mnNslmawx1ox0Ym/plM2hf3Cv7ULq5wXYpNmoZ8eE0kc7XHAXo7T2K0mW7Kt7DpQfZ81YqlcpLSC0VTcA9uK6N6/wE1ACqkzZAJNF4JRAeDQz063uS6bw9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769808657; c=relaxed/simple;
	bh=bBumb4wOVmbLHldIa2T2tL7+pqn5rzbhzytHwH/bXOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTdInjW8J1krkI/uI1Bf4DddzIUoVRIbc+76X+vGzFbcG3HbV7O3ruvCDU0QCgNG7peppd5UEWTbF30xRw+6fZ/Q2BJNsKE5Sx5jK+Nx8U9APCJz0lLWM+WDauAlRFIQUBjb0mgrPUSzMtYbvf+LpZXImq3MVrw1gdyjI7G2JB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=CsA4HBTI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="CsA4HBTI"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c7199e7f79so395940685a.0
        for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 13:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769808654; x=1770413454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Myo8BlVbIEmhmbpuUhZTyWcAan7tiuqku2w7KxqWRXI=;
        b=CsA4HBTIqU0nuIsMk709RQNBtXsbWFBhu7yNMgsJdmFDVcjgl5+6zeYGLbBLay4995
         DjA3Q+buZ6Wkz+yCvlulhMGF3D58wD2mIivO/hqcHIG5sL7Q1QS2pU5a9RAM/JpjVzGn
         VNiJQh7yG8O6Sv25tk/q3rZztTk7YcU0ZPVHw5OGhv5YHx5XdvjvvKJCg8fvkdQN0tId
         ombNikskk45fu4pbbnlvrzobFT8bmfdbIn0br07m6stg8J7G5wKuxLAMTm9jMCF/++dF
         4MZibwx0dK/a0bqQ4vy3zrqJomw+XqJZQheOPoSjWI3j/2g/PaAHjceCXc6/aEMUCnv0
         qVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769808654; x=1770413454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Myo8BlVbIEmhmbpuUhZTyWcAan7tiuqku2w7KxqWRXI=;
        b=vjrBG+DmI3yZdyyP2cctrZwhb5pCMETKzFadh40kxc5/CRHWYRVPVef2XKPc90+uNO
         HAI4tHnorUgH3LTsqsfHRjQwrAdcGUxk3E6cbKZLOFsQY+vBuehPf9J+mG/p7cqUN2Fn
         dJltuvWsanEgJnXliV8HJywaLuSZd3/jM6sYCPCszLd7vzF8eF2Pc7Ht1ql8Q+Qips+6
         Ajswlx6HXFpuVXq9MqtZy16VpYVG8fsSYwwjD+Q01SLCAkd9TX7rtnflo5vPHpopt43p
         SATAX64CFD4rWeaM4W8Qd9sc9IewBrHmtafeYJD8JdIbtQ6y7sXer3BK1DQ1WuwbmrwV
         fngQ==
X-Gm-Message-State: AOJu0YwzGa01TygBxrDyNibALNR0EdULheotuLFxt0x8hdCKUOLVnHMK
	SLLhO3m4Ps0xxH7f0bCtQZM2BG/M/3iI/1myr2wJlAzmcFSnaqDohtZNjATtahkjdb+WAOPhPAv
	4+quMAhQ=
X-Gm-Gg: AZuq6aIvi0ylgjUiGOIDbiGacz3zQyaunllnNX/ev3QzlopRZQxsYP5V4bM4Qq09oTn
	/2K8CVDU2398wYHGzTSGyKjkdcFwq3KJf6UQ/YQCBf45XSNuWIxtSkWv5J5bjqmAhaeiv560u5l
	iKRcXIlH3a3HquyLqllvz2FWdte3pxN0P+nfDVE009nmJGYpFw9ujkbCkegRthkliwBxPUTwaQ4
	vm5Dt31ECj4No5S/G+WBDLRQ+OVzWyPBzqEvSJF9hncLoDvgdQ9OA2fxiECJnzT7vwLIBP9AbNE
	PFoVv42YjFwOhbvFsP/0if7w121JX4C8MRF21el2gPvi7n1TFZJyuwDL7SyXJ1kYvcZfbDcRSbn
	d7m/zYR3uwfTxNsCkFmtilzncKWldZul0aLJIIDvV4oTmhaDevNOoxFnh1t007AKMjexPUJF5d3
	pm8nHTUKvQZ4WU/g3IdfwzynTY+EKdGKZn2udGfrd9PonePFXnkBvzZs/Fp2qdiWWS9G5pLQ==
X-Received: by 2002:a05:620a:ac1c:b0:8c9:fac8:c256 with SMTP id af79cd13be357-8c9fac8c30emr132485285a.77.1769808654253;
        Fri, 30 Jan 2026 13:30:54 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d28c71sm730869885a.33.2026.01.30.13.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 13:30:53 -0800 (PST)
Date: Fri, 30 Jan 2026 16:30:51 -0500
From: Gregory Price <gourry@gourry.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: Re: RFC: CXL Isolation Support
Message-ID: <aX0jC3DEqcnyrg7x@gourry-fedora-PF4VCD3F>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>

On Fri, Jan 30, 2026 at 01:47:08PM -0600, Cheatham, Benjamin wrote:
> Technical Details
> =================
> 
> 1. CXL memory may be used for kernel allocations
> 
> Kernel allocations in CXL aren't a problem at the moment because if the CXL.mem
> link goes down the hardware resets. When isolation is enabled, this isn't the case.
> The kernel can keep chugging along until it eventually errors out trying to access
> the now inaccessible memory (possibly causing data corruption until then).
> 

Two points:

1) isolating the normal native sysram usecase (N_MEMORY node) buys you
   less reliability than you think. It only buys you kernel safety.

Keeping kernel memory out of CXL only helps the kernel report problems,
it doesn't necessarily guarantee any particular system state in
userland after that occurs.

It's entirely possible (and altogether likely) that a large swath of
userland will become inoperable if the entire link goes down and a bunch
of that memory was used.

So if the goal is to have the system fully recover, this would require
much more isolation policy than just keeping the kernel out of CXL - you
would need most of the baseline distro to set cpuset.mem policies for
core services that ensure the userspace environment doesn't completely
blow up.

But even then, you have bigger issues for shared file-backed VMAs.

e.g. imagine libc gets demoted and comes back poisoned: kabloooey

But, you can at least get data from the system that the link went
down and even have a chance to investigate before nicely blowing up.

Which is at least much more helpful.



2) if N_MEMORY_PRIVATE nodes become accepted, this is a different story

In this case, the nodes are *completely* isolated except for *explicit*
use cases.  So a distro can in theory build a policy that dictates what
types of memory actually land on a particular device and how they can
get there.

The example would be using mempolicy to opt VMAs into private nodes,
while defaulting any given VMA to N_MEMORY nodes only.  This would be a
more reliable way to enforce isolation of critical components.

---

From a reliability perspective, my opinion has always been that kernel
isolation is a way for the kernel to deliver higher quality debugging
signal when an issue does happen, because when you're trying to figure
out why a million machines with CXL blow up - that little bit of signal
can save you many weeks of trouble.

> 
> Gregory Price has submitted a set that changes the second part of this flow to instead
> use sysfs [3]. With that, the need for udev rules is removed and users (or their tooling)
> can set their CXL memory to devdax mode before it's added to the system. At that point,
> all that needs to be done is restrict enabling isolation to CXL devices in devdax-mapped
> regions and make sure the memory mode doesn't change (i.e. devdax -> sysram).
> 

Just a clarifying point - the sysfs entries are representations of
kernel objects.

You can still do what you describe with a UDEV rule, just now the
sysram_region provides a step in which you can set the ZONE_MOVABLE
rule *before* the dax_kmem driver is engaged.

UDEV still possible, but now cleaner.

detects(region0)
    probe(sysram_region) <-- or cxl_devdax_region for device-dax instead

detects(sysram_region0)
    write(online_type="online_movable")
    probe(cxl_dev_kmem_Region)

tl;dr: Now you don't need a weird unbind step.

~Gregory
