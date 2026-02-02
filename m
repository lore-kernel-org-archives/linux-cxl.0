Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B05BA21
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047952; cv=none; b=OkAw+M9PZ6MqEy47oT03Zth6SP9NTE8x+NSH6eJdmRe2nVfaEAR8QgH8sVPyc/FvPel8YrOk+A2szddY69s7O2GzyIKHcI+Vf1TVZUfAooJq2KgHaKnm+oDVlrooMdrHIjprmBL9E/4cchhn29lGZ/MzgZvCzcHAcWPNii49gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047952; c=relaxed/simple;
	bh=V/GuZNOY38Pr3I0qsPIScqRQZoY4tFzRVSeLDEXY/b0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCmIGJS10bHyx3Y5snC87ZZ/kURVVwPoO1SVGVcje/vCXWb0ORM7vwOi6K1vYeexTVw4PhN96yUbo/ehjo6VHyXVKxXSTkTvxUJoM8W++Yn5vxvKQDn3EA22whlpGrzC8mZJyqzDkXtvnzIzbeX4SWOAOfE8qPPisAdlZdbR2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4WVV1GCxzHnH7c;
	Mon,  2 Feb 2026 23:58:10 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id CCE8440570;
	Mon,  2 Feb 2026 23:59:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Feb
 2026 15:59:07 +0000
Date: Mon, 2 Feb 2026 15:59:05 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: RFC: CXL Isolation Support
Message-ID: <20260202155905.00000cb0@huawei.com>
In-Reply-To: <aX0jC3DEqcnyrg7x@gourry-fedora-PF4VCD3F>
References: <b4f7a760-5cf4-4343-8f7e-9698ba435fa4@amd.com>
	<aX0jC3DEqcnyrg7x@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Fri, 30 Jan 2026 16:30:51 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Jan 30, 2026 at 01:47:08PM -0600, Cheatham, Benjamin wrote:
> > Technical Details
> > =================
> > 
> > 1. CXL memory may be used for kernel allocations
> > 
> > Kernel allocations in CXL aren't a problem at the moment because if the CXL.mem
> > link goes down the hardware resets. When isolation is enabled, this isn't the case.
> > The kernel can keep chugging along until it eventually errors out trying to access
> > the now inaccessible memory (possibly causing data corruption until then).
> >   
> 
> Two points:
> 
> 1) isolating the normal native sysram usecase (N_MEMORY node) buys you
>    less reliability than you think. It only buys you kernel safety.
> 
> Keeping kernel memory out of CXL only helps the kernel report problems,
> it doesn't necessarily guarantee any particular system state in
> userland after that occurs.
> 
> It's entirely possible (and altogether likely) that a large swath of
> userland will become inoperable if the entire link goes down and a bunch
> of that memory was used.
> 
> So if the goal is to have the system fully recover, this would require
> much more isolation policy than just keeping the kernel out of CXL - you
> would need most of the baseline distro to set cpuset.mem policies for
> core services that ensure the userspace environment doesn't completely
> blow up.
> 
> But even then, you have bigger issues for shared file-backed VMAs.
> 
> e.g. imagine libc gets demoted and comes back poisoned: kabloooey
> 
> But, you can at least get data from the system that the link went
> down and even have a chance to investigate before nicely blowing up.
> 
> Which is at least much more helpful.

Let's pretend it's tagged (just for ease of thinking about it).
So shareable that happens not be shared ever.

Application specific memory isolated to one application - using
famfs or similar.

Then it's safe enough, but maybe not that useful.  It's a possible
path to get to a world in which type 3 mem an be isolated.

Jonathan


