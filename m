Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A11E98FB
	for <linux-cxl@vger.kernel.org>; Wed, 18 Jun 2025 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246282; cv=none; b=nS3OS965sGAKkixp175jQjqka69KCImlDGPFXgeFxGfz8OdAJF++wsx9z1Pq3IAIbVszsmRoyZSg1fQ6zG4olepQYrHA/dAv9YOHm2wHl1wRWwF4PJ9b8yrvPoDa0RqYM9tqKH39YBH6eyN4yRw+8UzwqbsUbLqEY90j5gp0H/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246282; c=relaxed/simple;
	bh=FB6Xa3nyxrsDmbgW0ozvhzuX+TpPieBxwtmACCYNt0c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KnqelxIk3XJNBCsNGgP5/9V1I5eA/AlrMsDRZJ8TWNBZUjYmLz+DY4DM82SBEC+ov7qpm43899Os7ycuvRKqAWtmOdQHdUoEQcoSTlZd7xLwhM0Aq8KkubWRRWl7XPYH4uheP2N+MAw4r/BUAHVUK0uNvE4hP2n/X4LBoxaHFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bMhMg2FbPz6K9F4;
	Wed, 18 Jun 2025 19:29:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 41A0C140371;
	Wed, 18 Jun 2025 19:31:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 18 Jun
 2025 13:31:15 +0200
Date: Wed, 18 Jun 2025 12:31:14 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 1/3] hw/cxl: Storing physical ports info during
 enumeration
Message-ID: <20250618123114.00002b98@huawei.com>
In-Reply-To: <20250617094625.i2j7ewin7fy2b2nj@test-PowerEdge-R740xd>
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
	<CGME20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac@epcas5p2.samsung.com>
	<20250602135942.2773823-2-arpit1.kumar@samsung.com>
	<20250610152121.00004dda@huawei.com>
	<20250617094625.i2j7ewin7fy2b2nj@test-PowerEdge-R740xd>
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


> >> +#define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
> >> +#define LINK_STATE_FLAG_PRSNT            (1 << 2)
> >> +#define LINK_STATE_FLAG_POWER_OFF        (1 << 3)
> >> +
> >> +/* physical port control info - CXL r3.2 table 7-19 */
> >> +typedef enum {
> >> +    PORT_DISABLED = 0,
> >> +    BIND_IN_PROGRESS = 1,
> >> +    UNBIND_IN_PROGRESS = 2,
> >> +    DSP = 3,
> >> +    USP = 4,
> >> +    FABRIC_PORT = 5,
> >> +    INVALID_PORT_ID = 15
> >> +} current_port_config_state;  
> >
> >These aren't used as types really but more as defines.
> >Hence I'd be tempted to make them defines. Also provide
> >defines for the masks.
> >
> >Namespace the defines so it is obvious which field
> >they are in.
> >  
> Will the below changes be the right way to proceed?
> #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
> #define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1 etc.

Yes


...

> >For similar things we do have firmware update in there which
> >is a mixture of device side stuff and CCI specific handling.
> >That might ideally be split up.  Obviously not something for
> >this patch, but maybe we can avoid making CCI more bloated?
> >
> >To me it seems reasonable to store this in the port and set
> >it up whether or not the cci is connected.
> >  
> got it, will try the implementation accordingly. It will be helpful if could share some
> reference on handling the same.

+    /*physical ports information */
+    struct phy_port pports;
+

Move this stuff to the CXLUpstreamPort.
Query the data to fill it in will need to be late enough that
everything is there to query. cxl_usp_reset() might work similar to how
we fill in link registers etc there. 

Then when you handle any of the CCI calls, use CXL_USP(cci->d) to
get to that USP structure.  Check that you have the right type if necessary
first though. 

Jonathan




> >> +
> >>      /* background command handling (times in ms) */
> >>      struct {
> >>          uint16_t opcode;  
> >  
> 

