Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E86BAD53
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289161; cv=none; b=jzVYbicV61+yBTyPJ6R3it/uvHk0qQk2lbRzu/JMnPVzxVfFqiBbcLJ7tJ5G7FOE1GXkR2/AE7GXB7ySd79goY7PIFb81fNlOSvnzggL4DNALq7YZQuUF/BFG7k96fac/TzBpE4YSFU/Q3np2Vt3YPq9krN67dVWEkBl76vI4BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289161; c=relaxed/simple;
	bh=/xrEERA2Qi5VwBDAPc7uxvtPrEJtZopWgJGU7FG2/M8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQcNlTDozpEKsTdO/6ukhX4KsT+IoF4ZGo1VSLTyzyl7Bi7RMn503DU9FXZq00ken6MPKJHR1HlRJVaAVfgkylpVLMUP3y1w+GVenTKaG3X2wQ29gxPtv1KYQVOoFY5weQJp2f9kGwhAvFBI9dBt7M3+tywp2mNWapdDgX/zn40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TM41V5Z58z6K8x0;
	Sat, 27 Jan 2024 01:09:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9332814011D;
	Sat, 27 Jan 2024 01:12:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:12:34 +0000
Date: Fri, 26 Jan 2024 17:12:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: Sajjan Rao <sajjanr@gmail.com>, Dimitrios Palyvos
	<dimitrios.palyvos@zptcorp.com>, <linux-cxl@vger.kernel.org>
Subject: Re: qemu cxl memory expander shows numa_node -1
Message-ID: <20240126171233.00002a2e@Huawei.com>
In-Reply-To: <ZbPTL00WOo7UC0e6@memverge.com>
References: <CAAg4PaqsGZvkDk_=PH+Oz-yeEUVcVsrumncAgegRKuxe_YoFhA@mail.gmail.com>
	<CAGEDW0fWCfuG3KrNSwDjNVGAZVL9NJgF26Jqyd840HfQdNGLbA@mail.gmail.com>
	<CAAg4Pard=zh_5p650UcNdQEoQWZLM6G7KRqdPQHLmaR4oZMJ3w@mail.gmail.com>
	<CAGEDW0dVEk-QXuL=DPVvSP4t5cafz6N-r_SrCxgFnBfFOsixSA@mail.gmail.com>
	<CAAg4PaqgZcTXkWuys7FZjQdRChTkKj-ZnJQCdxpTMCxy4Hghow@mail.gmail.com>
	<20230823175056.00001a84@Huawei.com>
	<CAAg4ParSB4_2FU2bu96A=3tSNuwHqZwK0wCS18EJoPAq9kYEkw@mail.gmail.com>
	<CAAg4Pap9KzkgX=fgE7vNJYxEpGbHA-NVsgBY5npXizUbMhjp9A@mail.gmail.com>
	<20240126123926.000051bd@Huawei.com>
	<ZbPTL00WOo7UC0e6@memverge.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Jan 2024 10:43:43 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Jan 26, 2024 at 12:39:26PM +0000, Jonathan Cameron wrote:
> > On Thu, 25 Jan 2024 13:45:09 +0530
> > Sajjan Rao <sajjanr@gmail.com> wrote:
> >   
> > > Looks like something changed in QEMU 8.2 that broke running code out
> > > of CXL memory with KVM disabled.
> > > I used "numactl --membind 2 ls" as suggested by Dimitrios earlier,
> > > this worked for me until I updated to the latest QEMU.
> > > 
> > > Is this a known issue? Or am I missing something?  
> > 
> > I'm confused on how the description below ever worked.
> > Assigning the underlying memdev=cxl-mem1 to a numa node isn't going
> > to correctly build the connections the CFMWS PA range.
> >   
> 
> I've now seen 3-4 occasions where people have done this and run into
> trouble (for obvious reasons).  Is there anything we can do to disallow
> the double-registering of a single memdev to both a numa node and a cxl
> device?
> 
It would be novel for us to prevent people shooting themselves
in the foot ;) but I guess this should be fairly easy as the
numa node logic prevents the same one being used multiple times so can
copy how that is done.

This should do the trick (very lightly tested).
It's end of day Friday here so a formal patch can wait for next week.


diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f29346fae7..d4194bb757 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -827,6 +827,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             error_setg(errp, "volatile memdev must have backing device");
             return false;
         }
+        if (host_memory_backend_is_mapped(ct3d->hostvmem)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->hostvmem)));
+            return false;
+        }
         memory_region_set_nonvolatile(vmr, false);
         memory_region_set_enabled(vmr, true);
         host_memory_backend_set_mapped(ct3d->hostvmem, true);
@@ -850,6 +855,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             error_setg(errp, "persistent memdev must have backing device");
             return false;
         }
+        if (host_memory_backend_is_mapped(ct3d->hostpmem)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->hostpmem)));
+            return false;
+        }
         memory_region_set_nonvolatile(pmr, true);
         memory_region_set_enabled(pmr, true);
         host_memory_backend_set_mapped(ct3d->hostpmem, true);
@@ -880,6 +890,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
             error_setg(errp, "dynamic capacity must have backing device");
             return false;
         }
+        if (host_memory_backend_is_mapped(ct3d->dc.host_dc)) {
+            error_setg(errp, "memory backend %s can't be used multiple times.",
+               object_get_canonical_path_component(OBJECT(ct3d->dc.host_dc)));
+            return false;
+        }
         /* FIXME: set dc as nonvolatile for now */
         memory_region_set_nonvolatile(dc_mr, true);
         memory_region_set_enabled(dc_mr, true);





> ~Gregory

