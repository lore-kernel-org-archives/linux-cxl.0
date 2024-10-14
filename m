Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504D51547E4
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898628; cv=none; b=Ixf5kHzTQvJXdQocxj6VFLyrXuPKNXGhJESaM8KUHeSz0pju9coFe/rzx793ErfD08Gyq3Qi1hoXZ3jgmaS85j7zCMBA5QKqIiDVXoceEyLSYshtBphO4CbCuTb4L5D2RW7RNePsxeSlPvfEuV8mbsKsKkQOYOH1EAuToKZKDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898628; c=relaxed/simple;
	bh=18DrhyBfMqfPb6eOhsDAx4CpJ/4lAUU20aV9s1YL09E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQQVhv81t603N59rKJ6f0EZUi3cuuU9unTq13sQBnQlCS/E4HCphuNOHQbKhrANoL5F2FHo45enjq1BTcHoorBfcgp6DpPJCvEk/Qh5EYAKag0YZ3hh+N+Gn0MCb6Otw9xrUO6fHKvi95gE+MgoIfD+Bws7qsll0Iy0LLhN0CBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRsT9408gz67RYs;
	Mon, 14 Oct 2024 17:32:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F1B71400D9;
	Mon, 14 Oct 2024 17:36:56 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 11:36:55 +0200
Date: Mon, 14 Oct 2024 10:36:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Corey Minyard <minyard@acm.org>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>
CC: Klaus Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
	<peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Keith Busch
	<kbusch@kernel.org>, Lior Weintraub <liorw@pliops.com>, Jeremy Kerr
	<jk@codeconstruct.com.au>, Peter Delevoryas <peter@pjd.dev>,
	<qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>,
	"Klaus Jensen" <k.jensen@samsung.com>, Davidlohr Bueso <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management
 interface model
Message-ID: <20241014103653.00002c83@Huawei.com>
In-Reply-To: <ZQsDcmkZYCk0eVhA@mail.minyard.net>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
	<20230920124803.00005ae9@Huawei.com>
	<ZQrrgxHrfzmGyhZU@mail.minyard.net>
	<ZQr0LXsSRXGqJ4EL@cormorant.local>
	<ZQsDcmkZYCk0eVhA@mail.minyard.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 20 Sep 2023 09:36:34 -0500
Corey Minyard <minyard@acm.org> wrote:

> On Wed, Sep 20, 2023 at 06:31:25AM -0700, Klaus Jensen wrote:
> > On Sep 20 07:54, Corey Minyard wrote:  
> > > On Wed, Sep 20, 2023 at 12:48:03PM +0100, Jonathan Cameron via wrote:  
> > > > On Thu, 14 Sep 2023 11:53:40 +0200
> > > > Klaus Jensen <its@irrelevant.dk> wrote:
> > > >   
> > > > > This adds a generic MCTP endpoint model that other devices may derive
> > > > > from.
> > > > > 
> > > > > Also included is a very basic implementation of an NVMe-MI device,
> > > > > supporting only a small subset of the required commands.
> > > > > 
> > > > > Since this all relies on i2c target mode, this can currently only be
> > > > > used with an SoC that includes the Aspeed I2C controller.
> > > > > 
> > > > > The easiest way to get up and running with this, is to grab my buildroot
> > > > > overlay[1] (aspeed_ast2600evb_nmi_defconfig). It includes modified a
> > > > > modified dts as well as a couple of required packages.
> > > > > 
> > > > > QEMU can then be launched along these lines:
> > > > > 
> > > > >   qemu-system-arm \
> > > > >     -nographic \
> > > > >     -M ast2600-evb \
> > > > >     -kernel output/images/zImage \
> > > > >     -initrd output/images/rootfs.cpio \
> > > > >     -dtb output/images/aspeed-ast2600-evb-nmi.dtb \
> > > > >     -nic user,hostfwd=tcp::2222-:22 \
> > > > >     -device nmi-i2c,address=0x3a \
> > > > >     -serial mon:stdio
> > > > > 
> > > > > From within the booted system,
> > > > > 
> > > > >   mctp addr add 8 dev mctpi2c15
> > > > >   mctp link set mctpi2c15 up
> > > > >   mctp route add 9 via mctpi2c15
> > > > >   mctp neigh add 9 dev mctpi2c15 lladdr 0x3a
> > > > >   mi-mctp 1 9 info
> > > > > 
> > > > > Comments are very welcome!
> > > > > 
> > > > >   [1]: https://github.com/birkelund/hwtests/tree/main/br2-external
> > > > > 
> > > > > Signed-off-by: Klaus Jensen <k.jensen@samsung.com>  
> > > > 
> > > > Hi Klaus,
> > > > 
> > > > Silly question, but who is likely to pick this up? + likely to be soon?
> > > > 
> > > > I'm going to post the CXL stuff that makes use of the core support shortly
> > > > and whilst I can point at this patch set on list, I'd keen to see it upstream
> > > > to reduce the dependencies (it's got 2 sets ahead of it of CXL stuff
> > > > anyway but that will all hopefully go through Michael Tsirkin's tree
> > > > for PCI stuff in one go).  
> > > 
> > > I can pick it up, but he can just request a merge, too.
> > > 
> > > I did have a question I asked earlier about tests.  It would be unusual
> > > at this point to add something like this without having some tests,
> > > especially injecting invalid data.
> > >   
> > 
> > Hi all,
> > 
> > Sorry for the late reply. I'm currently at SDC, but I will write up some
> > tests when I get back to in the office on Monday.
> > 
> > Corey, what kinds of tests would be best here? Avocado "acceptance"
> > tests or would you like to see something lower level?  
> 
> My main concern is testing what happens when bad data gets injected, to
> avoid people coming up with clever names for exploits in qemu.  It's not
> so much for this code, it's for the changes that comes in the future.
> 
> And, of course, normal functional tests to make sure it works.  What a
> friend of mine calls "dead chicken" tests.  You wave a dead chicken at
> it, and if the chicken is still dead everything is ok :).
> 
> I'm fine with either type of tests, but I'm not sure you can do this
> with avocado.  It's probably about the same amount of work either path
> you choose.
> 
> -corey

Hi Klaus, All,

I was looking at what dependencies I'm carrying on my CXL tree and this
series is one of the bigger bits :(

Any plans to take it forwards?
I have some other stuff to solve to have a fully upstream QEMU
solution for the CXL fm-api over mctp (direct from host anyway), but
if this is blocked indefinitely tackling how to get a controller onto
a typical server system isn't going to be productive :(

As Davidlohr called out at in the CXL LPC Uconf [1] this is really handy
for testing his work on libcxlmi. A number of people are looking
at more sophisticated CXL fabric emulation and that will also need
us to close this gap!

No promises but maybe we can find someone to help with adding tests
if that's the only remaining blocker.

https://lpc.events/event/18/contributions/1876/attachments/1441/3072/lpc24-dbueso-libcxlmi.pdf [1]

Jonathan


