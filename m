Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B535181D05
	for <linux-cxl@vger.kernel.org>; Wed, 17 Jul 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230836; cv=none; b=qrwmmJSsumKdneGpGzAix0Vl4+GvWH+UkMTZUBDUG2BokwYjV+YkIbmopVjSdvondNLDQZO1GAiMtRjYwZVw4MezC/n2X2Tln10S/IX8WcWSZxu7qPTE/d8bFysYGPyPC71uuorVBEkCskclFc8LexUrU5B0L1VVdi0clpjOEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230836; c=relaxed/simple;
	bh=Jv8fXZ1EkLo8xJ1bpSD2ctWh3li3zE5lz3dOo1FODK8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8JHmabKVNhpN0In2P+r+XntDAsYqZseeHfdkWtlV5N+2jlSa+ImzTVYuOj+ABX+MYiaHNITvSc4ii9O0E4l8KsCuq2MpUNgcs5+GZA9k722KPo8wV3PRklO0A/6fhyW4SRFOP4nMAigz1/ePTpJgqzSvTU/KK/L9hnOitPwx9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPKqP1Jtlz6D8XN;
	Wed, 17 Jul 2024 23:39:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DD731140B30;
	Wed, 17 Jul 2024 23:40:31 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 17 Jul
 2024 16:40:31 +0100
Date: Wed, 17 Jul 2024 16:40:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Igor Mammedov <imammedo@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, "Dave Jiang" <dave.jiang@intel.com>, Huang
 Ying <ying.huang@intel.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: Re: [PATCH v5 10/13] hw/acpi: Generic Port Affinity Structure
 support
Message-ID: <20240717164030.000013fe@huawei.com>
In-Reply-To: <20240717110827-mutt-send-email-mst@kernel.org>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
	<20240712110837.1439736-11-Jonathan.Cameron@huawei.com>
	<20240715164841.1979fdea@imammedo.users.ipa.redhat.com>
	<20240717160258.00006893@huawei.com>
	<20240717110827-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 17 Jul 2024 11:11:06 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jul 17, 2024 at 04:02:58PM +0100, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 16:48:41 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Fri, 12 Jul 2024 12:08:14 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >   
> > > > These are very similar to the recently added Generic Initiators
> > > > but instead of representing an initiator of memory traffic they
> > > > represent an edge point beyond which may lie either targets or
> > > > initiators.  Here we add these ports such that they may
> > > > be targets of hmat_lb records to describe the latency and
> > > > bandwidth from host side initiators to the port.  A discoverable
> > > > mechanism such as UEFI CDAT read from CXL devices and switches
> > > > is used to discover the remainder of the path, and the OS can build
> > > > up full latency and bandwidth numbers as need for work and data
> > > > placement decisions.
> > > > 
> > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > Tested-by: "Huang, Ying" <ying.huang@intel.com>
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> > > 
> > > ACPI tables generation LGTM
> > > As for the rest my review is perfunctory mostly.  
> > 
> > The node type points and missing descriptor applying equally to generic
> > initiators. I'll add a couple of patches cleaning that up as well as 
> > fixing them up for generic ports.
> > 
> > For the exit(1) that was copying other similar locations. I don't
> > mind changing it though if something else is preferred.
> > 
> > Given tight timescales (and I was away for a few days which didn't
> > help), I'll send out a v6 with changes as below.
> > 
> > Jonathan
> >   
> 
> I'm working on a pull and going offline for a week guys, what's not in
> will be in the next release.  Sorry.

No problem. Thanks for letting us know!

In that case I'll sit on v6 for a while and hopefully we can get it
lined up early next cycle without too much bios-tables test churn pain.

Jonathan
