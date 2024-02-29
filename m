Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6E757E4
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229160; cv=none; b=E/BfOWAm5Js/6tN4K+/CsTH1rkToiVQO3TXXWlkvO4t9U36pQFDBeAUifIAhrN6g5zYBXJW6j5g3zP2DdQpiXjEwspJ+QoWmLKdbko/+raJKhDhPqAnVT9swZiuw7tdd0Sef6NRWnMq8LkqPhbvoG1adhOgHXUmOxb9Kpn2rR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229160; c=relaxed/simple;
	bh=3XHzcDQ3BdpugAYo88NvzKpQxuXlSOu6WO/2FPWINJE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvJ8YkFeR7KwVzkvAza+gnTT73ObKy11tVhWhiAyfQZ/exTJ0he8XfAeRh27YIFYnMP6SgmuttXgzz8ffCrwVcyUQNWMgl59ss0RSQ7EfOCERXligkUVI4VHWV9K7sfYlUlEFqr2aEfBoihrYbe+LbzPVBT0iTqj2s55FtMACvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TlzGF3GXlz6K647;
	Fri,  1 Mar 2024 01:48:05 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3394F140B67;
	Fri,  1 Mar 2024 01:52:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 17:52:33 +0000
Date: Thu, 29 Feb 2024 17:52:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Gregory Price <gregory.price@memverge.com>
CC: Liu Jingqi <jingqi.liu@intel.com>, <qemu-devel@nongnu.org>,
	<ankita@nvidia.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov
	<imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	<linuxarm@huawei.com>, Markus Armbruster <armbru@redhat.com>, Daniel Black
	<daniel@linux.ibm.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] hmat acpi: Do not add Memory Proximity Domain
 Attributes Structure targetting non existent memory.
Message-ID: <20240229175232.000017d2@Huawei.com>
In-Reply-To: <ZeC7EO/fQKScG8Rb@memverge.com>
References: <20240229162545.7887-1-Jonathan.Cameron@huawei.com>
	<20240229162545.7887-2-Jonathan.Cameron@huawei.com>
	<ZeC7EO/fQKScG8Rb@memverge.com>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 29 Feb 2024 12:28:51 -0500
Gregory Price <gregory.price@memverge.com> wrote:

> On Thu, Feb 29, 2024 at 04:25:44PM +0000, Jonathan Cameron wrote:
> > If qemu is started with a proximity node containing CPUs alone,
> > it will provide one of these structures to say memory in this
> > node is directly connected to itself.
> > 
> > This description is arguably pointless even if there is memory
> > in the node.  If there is no memory present, and hence no SRAT
> > entry it breaks Linux HMAT passing and the table is rejected.
> > 
> > https://elixir.bootlin.com/linux/latest/source/drivers/acpi/numa/hmat.c#L444
> >   
> 
> Nit: This link becomes out of date pretty much immediately, consider
> using a versioned link.
Good point.

https://elixir.bootlin.com/linux/v6.7/source/drivers/acpi/numa/hmat.c#L444

> 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  hw/acpi/hmat.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
> > index 3042d223c8..723ae28d32 100644
> > --- a/hw/acpi/hmat.c
> > +++ b/hw/acpi/hmat.c
> > @@ -204,6 +204,13 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *numa_state)
> >      build_append_int_noprefix(table_data, 0, 4); /* Reserved */
> >  
> >      for (i = 0; i < numa_state->num_nodes; i++) {
> > +        /*
> > +         * Linux rejects whole HMAT table if a node with no memory
> > +         * has one of these structures listing it as a target.
> > +         */
> > +        if (!numa_state->nodes[i].node_mem) {
> > +            continue;
> > +        }
> >          flags = 0;
> >  
> >          if (numa_state->nodes[i].initiator < MAX_NODES) {
> > -- 
> > 2.39.2
> > 
> >   

