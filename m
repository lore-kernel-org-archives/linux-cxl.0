Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB327D776
	for <linux-cxl@vger.kernel.org>; Fri,  8 Aug 2025 13:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754659761; cv=none; b=UrXbn8Aa9H4E7Yj0BInPoU69wfhKWF9eNBPPVkRziyH0ERGNgxJZKPbXZegCBE4XhtI9lvBuf2e9JB9MtfhcVPD8NfOTOFRpBNyPCpHKmeLZVOp4/aU+hGpfrvTkPFEKkpWGGD3aObelz+GbomaqVcDjVYJqwr6iYlt8cj7Eapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754659761; c=relaxed/simple;
	bh=PeHdIPnatu4W1EUPLbA/8vhKUXn5f7R0LK4aMhpfpzU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRWtanOxKcddDa7omODtfEf6TxuvpTYlJut09f3sTZvvzgOJRXmPh7gBsbu7jGJJTB7TsnWVADQRf53qpWsM8CHPLP0fkC7FFhMIQxfFGldQmhF+hht/NfjeB23FLnfW6/mqfXywQikL0LnFEqt8JSGMLhtjOFP9SW5rtSVOgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz4Zb62mgz6M4LB;
	Fri,  8 Aug 2025 21:27:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E91781402ED;
	Fri,  8 Aug 2025 21:29:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Aug
 2025 15:29:09 +0200
Date: Fri, 8 Aug 2025 14:29:07 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <armbru@redhat.com>,
	<dave@stgolabs.net>, <linuxarm@huawei.com>
Subject: Re: [PATCH v5 1/7] hw/cxl/events: Update for rev3.2 common event
 record format
Message-ID: <20250808142907.000022f4@huawei.com>
In-Reply-To: <20250807154346.2209-2-shiju.jose@huawei.com>
References: <20250807154346.2209-1-shiju.jose@huawei.com>
	<20250807154346.2209-2-shiju.jose@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
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

On Thu, 7 Aug 2025 16:43:40 +0100
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.2 section 8.2.9.2.1 Table 8-55, Common Event Record
> format has updated with optional Maintenance Operation Subclass,
> LD ID and ID of the device head information.
> 
> Add updates for the above optional parameters in the related
> CXL events reporting and in the QMP commands to inject CXL events.
> 
> In qapi/cxl.json added fields of Common Event Record to a common
> structure CXLCommonEventBase.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Hi Shiju,

Sign off chain doesn't make sense. Drop my SoB.  I guess this is because
it went through my tree at some stage and hence was tagged by
me. Given it's your patch, you should drop that from new versions.

Jonathan


> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
