Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062C33F6;
	Fri, 21 Mar 2025 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558996; cv=none; b=DtZwPbInIuRfSVnWvvzHwNrKzNCGpMePyGxMi/r1PPLab6K2pjA/evNoEjtMXIhwv0hijpve8MqFmqbCqaKwyy5n8pyxm2WiDU1UxZVGuOuHaa7klraieI4pF2Z5u5zgULU43UQT/yAfreYfd4mj7x4i972yzw4vD6K09QtJ+tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558996; c=relaxed/simple;
	bh=iAvRp7hOhZgDHzu1tV5l1/1yvxZpaC4IobbGa6g5Qa0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoXaKdVrxF8MD4IyO6h96FHONVovKvzcTpGtZOO+9eXl45cn5/AIzE9AJZ4vALqH/5dT4sN9rg27rPcF68oVE+hG5KvwgXktr1RNMA1pdndQlniK2jCXM931EM6qTxYEZ+4oDXL+mJQyJ3OCeDWxwO4YK5SJFEWnHlxhSTKHljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK1Py414mz6M4qn;
	Fri, 21 Mar 2025 20:06:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F4205140856;
	Fri, 21 Mar 2025 20:09:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 13:09:51 +0100
Date: Fri, 21 Mar 2025 12:09:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch v1 0/3] Fix using wrong GPF DVSEC location issue
Message-ID: <20250321120950.000039ba@huawei.com>
In-Reply-To: <0f537373-7a71-49a5-a4d3-8adb0ef41349@zohomail.com>
References: <20250319035516.222054-1-ming.li@zohomail.com>
	<20250321021441.vdmo5txhvb6kya3a@offworld>
	<20250321035918.yyicfmvmpm7selin@offworld>
	<0f537373-7a71-49a5-a4d3-8adb0ef41349@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 21 Mar 2025 14:55:42 +0800
Li Ming <ming.li@zohomail.com> wrote:

> On 3/21/2025 11:59 AM, Davidlohr Bueso wrote:
> > On Thu, 20 Mar 2025, Davidlohr Bueso wrote:
> >  
> >> On Wed, 19 Mar 2025, Li Ming wrote:
> >>  
> >>> But I am not sure if all dports under a same port will have same
> >>> configuration space layout, if yes, that will not be a problem. If I am
> >>> wrong, please let me know, thanks.  
> >>
> >> Yes, when caching the dvsec was suggested, it was my assumption that the
> >> config space would be the same.  
> >
> > Ultimately I don't know what the expectation is here, but your updates
> > do allow more flexibility from vendors, I guess(?). It's a bit late
> > in the cycle, unfortunately, so if these are to go in for v6.15, they
> > would be considered a fix imo, otherwise perhaps they are wanted for
> > v6.16 or not at all (patch 3 does look useful regardless)?  
> 
> My understanding is that the expectation of the patchset is to avoid using a wrong GPF DVSEC in case of dports under a same port have different config space layout. And I think the change is more closely to the description of CXL spec.
> 
> If the case(dports under a same port have different config space layout) would not happen, maybe add a comment in cxl_gpf_port_setup() is another option.
> 
> Yes, if patch 1 & 2 are considered to be merged, they are worth a fix tag. And patch 3 is an obvious cleanup change.

I think they can indeed have different layout (in theory).
Seems moderately unlikely to occur in real devices, but you never know.

So I think a fixes tag would be valid.

Jonathan

> 
> >
> > Based on some of the topologies listed in qemu, I did some testing (and
> > this was also why the same dvsec config layout) and see things working as
> > expected.  
> 
> Thanks for testing.
> 
> 
> Ming
> 
> [snip]
> 

