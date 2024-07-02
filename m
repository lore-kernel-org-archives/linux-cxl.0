Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1311BC06F;
	Tue,  2 Jul 2024 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933511; cv=none; b=b/AE3d4v7UjuBqs4OceMHN+jPp764Jn1DoDNd2Fc6wlKBBvRqbr5I6LwULlPHuM7F3V8Q/U940qF+FPv1aWaYOvJUqfM+8/B+pv4AemRnzqug/ZXz6piQNm2+bDKyzZpDCweFqhr3ZPE+OMlsPvAMqomjZAq5BKoQc8BHBCVL/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933511; c=relaxed/simple;
	bh=B2rXYLGFgitAB5X44YsnmzwteXueZccB7OliwxBo05Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QesTYHBfbPazaYtA3aALorEQza4fqQ77eiRKTMh+/Ipef93F0yt7IneorDhZZRiVIfhlnu+Tx0tOAwLy3e65azWA37dbIMyOTuc2j+NHxlwaTXlgaNlXBeSVlr5E+/B2w6PbKN9WWMiZPbn46OJf4wQpPtNo010PDsJ1c/JR2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD6295glTz6K97K;
	Tue,  2 Jul 2024 23:16:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E333140517;
	Tue,  2 Jul 2024 23:18:25 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 16:18:24 +0100
Date: Tue, 2 Jul 2024 16:18:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <Terry.Bowman@amd.com>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <ming4.li@intel.com>,
	<vishal.l.verma@intel.com>, <jim.harris@samsung.com>,
	<ilpo.jarvinen@linux.intel.com>, <ardb@kernel.org>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <Yazen.Ghannam@amd.com>,
	<Robert.Richter@amd.com>
Subject: Re: [RFC PATCH 4/9] cxl/pci: Map CXL PCIe ports' RAS registers
Message-ID: <20240702161823.00003749@Huawei.com>
In-Reply-To: <aba901a8-4d7d-4f2e-9656-7d6b6a1bc4d2@amd.com>
References: <20240617200411.1426554-1-terry.bowman@amd.com>
	<20240617200411.1426554-5-terry.bowman@amd.com>
	<20240620134626.00004dc4@Huawei.com>
	<aba901a8-4d7d-4f2e-9656-7d6b6a1bc4d2@amd.com>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> >> index 0c79d9ce877c..51a4641fc9a6 100644
> >> --- a/drivers/cxl/mem.c
> >> +++ b/drivers/cxl/mem.c
> >> @@ -45,10 +45,39 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
> >>  	return 0;
> >>  }
> >>  
> >> +static bool cxl_dev_is_pci_type(struct device *dev, u32 pcie_type)  
> > Naming perhaps needs work to make it clear this is checking if
> > it's a CXL device of that type.
> > Also, seems like general functionality that belongs in core/pci.c or
> > similar.  
> 
> Any suggestions on what to use for the rename?
dev_is_pcie_of_type() perhaps?
The dvsec bit obviously is less general but might be bandled
separately with
	if ((dev_is_pcie_of_type(dport->dport_dev, PCI_EXP_TYPE_DOWNSTREAM) ||
	     dev_is_pcie_of_type(dport->dport_dev, PCI_EXP_TYPE_ROOT_PORT)) &&
	    cxl_dev_regloc(dport->dport_dev))

where 
cxl_dev_regloc() is that lookup and is also used in core/regs.c

Or something along those lines.
