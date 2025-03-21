Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACD233F6;
	Fri, 21 Mar 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558774; cv=none; b=HXiVITsjjBDc2NgSeA4uW6BERvbrJtR97TXIGxgcgqwl+56R5bR9oYQ+GEvl6Vf/vl7UNbpaUUsEaFaOleXDbg4SNHTOzQwaYtgvF8qmsOKBgx7+l6TGB2p020z770NofjTOzBCMLI0PEPbRR4ixzlGh5Njp1VVdyXWycw2VomY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558774; c=relaxed/simple;
	bh=YyOLMCXC5S2nbQIJuua2zlV2vpC2OBfNberPkLIPP48=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyTy5Iw26I8llq7VS+JsqzxJkSeGnDt1ZyluRhN5i1TPsOb1C7P6Y2oC3pUNPUyzoxQvgy4DUV1DtihzNby9i7hl7eT4UN3snR2d/h0Brr1MRqxRqSPv0MPf9ch3i62uwukYzqgnr5XalZq55VPY3wL94kFPnExK05GhGtIGyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZK1Kh1q8lz6M4h2;
	Fri, 21 Mar 2025 20:02:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A7644140517;
	Fri, 21 Mar 2025 20:06:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Mar
 2025 13:06:09 +0100
Date: Fri, 21 Mar 2025 12:06:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Li Ming <ming.li@zohomail.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC Patch v1 3/3] cxl/pci: Drop the parameter is_port of
 cxl_gpf_get_dvsec()
Message-ID: <20250321120607.00004f1f@huawei.com>
In-Reply-To: <20250321052309.qkhlyabmcgbxtmtf@offworld>
References: <20250319035516.222054-1-ming.li@zohomail.com>
	<20250319035516.222054-4-ming.li@zohomail.com>
	<20250321052309.qkhlyabmcgbxtmtf@offworld>
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

On Thu, 20 Mar 2025 22:23:09 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Wed, 19 Mar 2025, Li Ming wrote:
> 
> >The first parameter of cxl_gpf_get_dvsec() is a struct device, can be
> >used to distinguish if the device is a cxl dport or a cxl pci device by
> >checking the PCIe type of it, so the parameter is_port is unnecessary
> >to cxl_gpf_get_dvsec(), using parameter struct device is enough.
> >
> >Signed-off-by: Li Ming <ming.li@zohomail.com>  
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
