Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7013563C3
	for <linux-cxl@vger.kernel.org>; Thu, 18 Dec 2025 15:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766072921; cv=none; b=db93e8k3DUWdL6wFIR57CAl1/DUP5niOTY3Ja6A7SCDsc7dnzFO7N+0YFgTUAKwzxrJjDsa0B7cAzEGrzWgPFmPVDmy6qGazRRUZBPWr0IDmOUj3UkT/zajOKZaXNGtNAxBxHvWDZH7jLxCSaIoGtNSKzrmO6KYB9sGk0qtQeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766072921; c=relaxed/simple;
	bh=JU885sk3XOjxrp64rmTKezw/3tZvXcSP8+o1tHf9rdQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JfImAwhndWz6u1ERdL053XYsG/2okWYbZlBizXPIWwSKH/uiKl8GwQcpe7YndMSMcolusol0z4OzV4CgJy34Qm3i3B1nM7HQ1+FC6v5ETLjpjUMV4ASrgeiK5DPhAdNpBujYU7wr1suY83ihPY//M1VbyloQiHqOCEZo04fQKyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXFS356h0zJ467G;
	Thu, 18 Dec 2025 23:48:03 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id DFB084056B;
	Thu, 18 Dec 2025 23:48:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 15:48:34 +0000
Date: Thu, 18 Dec 2025 15:48:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <ira.weiny@intel.com>,
	<alucerop@amd.com>, <a.manzanares@samsung.com>, <dongjoo.seo1@samsung.com>,
	<mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <linux-cxl@vger.kernel.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/5] hw/cxl: Allow BI by default in Window restrictions
Message-ID: <20251218154832.00000159@huawei.com>
In-Reply-To: <87wm2ki1wm.fsf@pond.sub.org>
References: <20251103195209.1319917-1-dave@stgolabs.net>
	<20251103195209.1319917-4-dave@stgolabs.net>
	<87wm2ki1wm.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 10:18:17 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Davidlohr Bueso <dave@stgolabs.net> writes:
> 
> > Update the CFMW restrictions to also permit Back-Invalidate
> > flows by default, which is aligned with the no-restrictions
> > policy.
> >
> > While at it, document the 'restrictions=' option.  
> 
> I'd split the patch.  Up to you.
Hi Markus,

As you note below the interface hasn't been in any release anyway and
is part of the long backlog I'm carrying and slowly getting
upstream. Bringing this in from the start with that restrictions
control should be fine.

However, backwards compatibility does need addressing
as this changes the default for things we do create today (with
no restrictions).

In this particular case, I don't think we care because there are no
BI capable devices before this series - so there can't be anything
using this feature for the host memory range it describes.

As such, the only result is the ACPI table says we have an extra
flag set which no one will care about.  Will need to update
the ACPI table tests though. I'll check.

Migration of CXL topologies is horribly broken currently anyway
so that's not a problem here. Given current usecases are strictly
software stack verification fixing that isn't a priority (yet).

Jonathan

> 
> > Tested-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
> > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > ---
> >  hw/cxl/cxl-host.c | 2 +-
> >  qapi/machine.json | 3 ++-
> >  qemu-options.hx   | 4 +++-
> >  3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> > index e420b25176a6..ed0c76a31980 100644
> > --- a/hw/cxl/cxl-host.c
> > +++ b/hw/cxl/cxl-host.c
> > @@ -64,7 +64,7 @@ static void cxl_fixed_memory_window_config(CXLFixedMemoryWindowOptions *object,
> >      if (object->has_restrictions) {
> >          fw->restrictions = object->restrictions;
> >      } else {
> > -        fw->restrictions = 0xf; /* No restrictions */
> > +        fw->restrictions = 0x2f; /* No restrictions */
> >      }
> >  
> >      fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 225690d2986a..85e31432b038 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -555,7 +555,8 @@
> >  #     BIT(2) - Volatile
> >  #     BIT(3) - Persistent
> >  #     BIT(4) - Fixed Device Config
> > -#     Default is 0xF
> > +#     BIT(5) - BI
> > +#     Default is 0x2F
> >  #
> >  # @targets: Target root bridge IDs from -device ...,id=<ID> for each
> >  #     root bridge.  
> 
> This changes the default of @restrictions.  No problem since
> @restrictions has not been in any release.  If it was, we'd have to
> consider backward compatibility.
> 
> [...]
> 
> 

