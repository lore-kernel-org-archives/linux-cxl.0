Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72B2116E9
	for <linux-cxl@vger.kernel.org>; Wed, 18 Jun 2025 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246376; cv=none; b=ka5gTMiPO+4WNJi8ZTkcLvWHgSpdg+0S2g7Cv9AjUfU+24OsiSt9SffgEK1lkCdDWRBZZmALEfrul3Ezq6c2YQxyjC16qGHTZcFByjsNMtZKK6QNspuskhsfsuiFIkujkoukNcoqVAaRsAvpa7VuKroFhlZrvXpqObeho5217Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246376; c=relaxed/simple;
	bh=Tr8lMbn5YanrmdXRD+qmpLmrVEnHThkQSFaZWQZRdcg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9KY/VdlsxxNrq/xSiejnGpLNk6bTl2ytiNfa2NXP29/mc4vOVCz0reXEEmqio11pEWgJk4z1rL2PZW4/SxUdeIX9FHeXeLzPumC4vPQyuZXQCpnmLQz2qiUIVoCigkzp/qJMhCFh8PXfuGVr2puGeUxrLYc1w2ku9XKiHQ1sZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bMhPV2Dshz6K934;
	Wed, 18 Jun 2025 19:30:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 19678140371;
	Wed, 18 Jun 2025 19:32:51 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 18 Jun
 2025 13:32:50 +0200
Date: Wed, 18 Jun 2025 12:32:48 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 3/3] hw/cxl: Add Physical Port Control (Opcode 5102h)
Message-ID: <20250618123248.000004e4@huawei.com>
In-Reply-To: <20250617101136.z4ityaayhuglrvqu@test-PowerEdge-R740xd>
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
	<CGME20250602140045epcas5p2445a99b249ba9588af027d59b0c8bd35@epcas5p2.samsung.com>
	<20250602135942.2773823-4-arpit1.kumar@samsung.com>
	<20250610154501.0000213b@huawei.com>
	<20250617101136.z4ityaayhuglrvqu@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

> >> +        /* Assert PERST involves physical port to be in  
> >wrap at 80 chars.  
> okay
> >> +         * hold reset phase for minimum 100ms. No other calls
> >> +         * are entertained until Deassert PERST command.
> >> +         * https://patchwork.ozlabs.org/project/linux-pci/patch/20190523194409.17718-1-niklas.cassel@linaro.org/#2178369  
> >
> >Blocking other commands is fine but we should lock up emulation of other stuff
> >in the system and I think you currently do.
> >  
> got it. I think you meant 'we should *not lock up..'
Absolutely!
