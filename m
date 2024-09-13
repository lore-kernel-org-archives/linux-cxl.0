Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB62C80
	for <linux-cxl@vger.kernel.org>; Fri, 13 Sep 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228347; cv=none; b=XRaHAhaFUDib0PLY3qoLtFx9h1zCYWyfOEN8Uy5weNv4Rpsta4RgtOzr0eQT0sIZc2T6vn2+B7USJOoCXpTnBr2+aTT2l4FibarvIpvlaqWn+RS8KtSF6CkDmVzzAIXUT/kO7tLlmjoX+ZAJxr1BQAx6f9FUd5dj/PgDgtcgS9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228347; c=relaxed/simple;
	bh=Sq+E1KJzHsf1IR/cyTQXi3D8vCI9zi5q6E8F/SXxl7A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKvJe2o3Zou3w/hfjVsQuyCLyMSokVR8+lwxWV6e/uk9FDdJWdaZ4WigGcdCiigw/0HbCbOfYgCX8A9+qSnVG/GXAav2kTIQbYftkfQtl/dYdtsQ+XUVaKghxExQC1T0X0uCHPdOs1rcN+5ANvIKZwRM4LLxNxnjnKgx88LQcxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X4sy90c4fz67pJF;
	Fri, 13 Sep 2024 19:48:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 003E8140519;
	Fri, 13 Sep 2024 19:52:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 13 Sep
 2024 13:52:19 +0200
Date: Fri, 13 Sep 2024 12:52:18 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"Ravis.OpenSrc@micron.com" <Ravis.OpenSrc@micron.com>, "ajayjoshi@micron.com"
	<ajayjoshi@micron.com>, "emirakhur@micron.com" <emirakhur@micron.com>,
	"john@jagalactic.com" <john@jagalactic.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"sthanneeru.opensrc@micron.com" <sthanneeru.opensrc@micron.com>,
	"sthanneeru@micron.com" <sthanneeru@micron.com>, Haseeb Gani
	<hgani@marvell.com>, Sathesh B Edara <sedara@marvell.com>, Srinivasa Rao
 Jampala <sjampala@marvell.com>, Shariful Alam <sharifula@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>, Dharmesh Pitroda <dpitroda@marvell.com>
Subject: Re: [RFC PATCH] cxl/pci: Set default timeout for background
 operations
Message-ID: <20240913125218.00003099@Huawei.com>
In-Reply-To: <PH0PR18MB47345DDF79DB8970D40D3BC5C7922@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <PH0PR18MB47345DDF79DB8970D40D3BC5C7922@PH0PR18MB4734.namprd18.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 2 Sep 2024 06:42:34 +0000
Shinas Rasheed <srasheed@marvell.com> wrote:

> Hi,

Hi Shinas,

Note this is my view. Opinions may differ!

> 
> Trying to revive this discussion about background commands. I'm sorry if more on the topic has been discussed elsewhere, 
> but this is a patch that I could find which related to the same topic.
> 
> The requirement for default timeouts (or atleast a mechanism to provide timeouts to the command structure) seems to be needed
> since the CXL spec doesn't seem to explicitly deny userspace access to background commands.

The CXL spec (quite rightly) doesn't speak at all about providing userspace or other
access to anything. This is purely an OS implementation question so
this is the right place to address it for Linux.

It would be perfectly valid for an OS to mediate fully every command
including all vendor defined ones. If there is a command it doesn't
know about, default to blocking it.

There is a path to enable 'some' background commands from userspace
but only the ones that support abort.


> This seems to constrain a lot of
> functionality with respect to Vendor Defined commands as well, if a command needs to be implemented as background.

Indeed. If someone has a vendor defined command that locks the device up for
a long period, then the kernel may well have a quirk in future to
block that command (if we enable vendor commands from userspace
in general - see the fwctl discussion).  That may be a necessary precaution
to avoid the kernel locking up for substantial periods.



> 
> >> sthanneeru.opensrc@ wrote:  
> >> > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> >> > 
> >> > The CXL 3.0 specification outlines background operations,
> >> > and support for handling these operations was added in following patch.
> >> > 
> >> > Link: https://lore.kernel.org/all/20230523170927.20685-5-dave@stgolabs.net/
> >> > 
> >> > Mailbox commands like ‘Log Populate’ use background operations
> >> > to complete the execution of the command.
> >> > This can lead to a timeout, since there is currently no option
> >> > in the ioctl cxl_send_command structure to specify
> >> > a timeout value. The default values being zero can lead
> >> > to the driver reporting false negatives to the application.
> >> > 
> >> > This patch aims to establish default values, enabling mailbox commands
> >> > that operate in the background to continue functioning even
> >> > if a timeout is not set in the userspace application.    
> >> 
> >> The reason there are no defaults is because userspace is not allowed to
> >> issue background commands. The CXL background command definition is
> >> awkward in that it allows a single command to monopolize the mailbox for
> >> an indefinite amount of time.  
> 
> I understand this is a design adopted by the kernel, and not actually by the CXL spec (at least I don't see it
> specifying explicitly that background commands are not allowed in band).

(I see you touch on this below)
The background commands are 1 at a time.  Given some background commands
are used by the kernel, the ability to run non background commands at the
same time doesn't help us in the general case.  Hence proposal
is to only allow userspace use of commands that may be cancelled.
If the kernel wants to use the mailbox for a background command and
one is already being processed by the device, the kernel can just cancel it.

> 
> >> 
> >> Instead, the approach taken with Firmware Update and Sanitize is that a
> >> kernel sysfs ABI mediates access to the mailbox and facilitates bounded 
> >> timeslices between command submissions. It effectively allows the kernel
> >> to manage fairness and more importantly preempt userspace if it needs to
> >> issue its own commands.
> >> 
> >> I assume you are only seeing this lack of a default due to building with
> >> CONFIG_CXL_MEM_RAW_COMMANDS=y? If yes, "raw" means "raw" and the kernel
> >> is mostly taken out of the loop of saving userspace from itself.  
> 
> This seems to imply that no vendor defined command can be background commands. Please correct me if
> I'm wrong, since Vendor defined commands have to be sent as raw commands, and the absence of default timeouts
> indicate that the command will be immediately timed out.

The fwctl discussion may provide a path for this, but I think
that will still only support commands we can abort.

> 
> Also, I understand the point that background commands (since there can only be one) monopolizes the
> mailbox, and hence cannot be exposed to userspace and as I see the background command handling goes synchronously
> with the usual command handling in the kernel (ie; foreground command has to wait for the background command to complete or timeout)
> but doesn't this defeat the purpose of the spec defined ability to run a foreground command while a background command is
> underway?

It is a valid optimization to run non background commands. If there
is a clear use case then I think we'd be happy to see patches.
As you say though, that doesn't enable userspace background comamnds
though as some of the commands the kernel uses are background as well
so we still need to be able to abort the ones userspace issued.

> 
> >> 
> >> All that said, ugh, "Log Populate" has no facility to time bound the
> >> population of the log. I do not think it is tenable for Linux to
> >> surrender mailbox access for an indefinite uninterruptible amount of
> >> time... unless you want to handle "Log Populate" like Sanitize where the
> >> unbounded background operation is tolerated because the device is taken
> >> offline?  
> >
> >It may be pointless to do a component state dump only on an offline device.
> >My assumption is this one is hardware debug only.  Patches out of
> >tree or behind a really scary sounding config variable perhaps?
> >Other than vendor log I don't think populate log applies to the other
> >log types yet (they don't mention it anyway!)
> >
> >Jonathan  
> 
> Am I wrong to understand that this design decision is still in the open right now?
> 
> Another concern was that right now, a WARN_ONCE is issued when a raw command is ensued. Maybe this belongs
> on a different thread, but are raw commands to be depreciated (if then how can Vendor Defined commands be sent?)
See fwctl discussion for Vendor Defined command.
Right now Dave has focused on Get / Set feature but we'll expand to others.
The FWCTL area in general is probably going to be discussed at the various
conferences in Vienna next week, so for now this is a 'watch this space'.

We did discuss the option of possibly supporting vendor defined commands explicitly
if some or all of these conditions were met.
1) There was clear documentation.
2) Possibly a proposal for similar feature in the CXL specification or another
   industry spec.  (to ensure we don't end supporting a never ending sequence of
   similar vendor specific commands)

In a sense (1) means they are a defacto standard so we can be sure
of side effects etc and things like how long they take.

Jonathan

> 
> 

