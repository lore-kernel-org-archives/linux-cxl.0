Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AB726B2D5
	for <linux-cxl@vger.kernel.org>; Tue, 28 Oct 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664995; cv=none; b=jU7ue0ZueAYZx8EtZWU25BuLTES9XJwMWcmsityWfllNBhV66IqLFX7TFRxJTPzRg/K4jWqCW4DqG8iZ5Hh15I2jDx49D+UEAwFdb7wDfkreg/D7jYcIXRCH8zLsYUG01fMqdvjrI/0DvodcptFjT3KBrQE7b/erBr1VuqMf7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664995; c=relaxed/simple;
	bh=Wyxn9lmhULPNi2wxL0Ph8BtCC4dm/NPkh1SZvX2BI5k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6QcahqZ0rSY1VqPP+r4S/UuomOLT7dfvduPQStEeCbsENUjlQB/Ti+MJ81uvSJGbpYCeuqBk1NkY9KFxNroBQigCJhyazUlH2xl8s5mrveqmZvzy7wATnz8Iou8n6+HotLusSmMy6WVURPO6gbxQFMxAze2ElXOzujUSeaKUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cwvGt6Gn3z67l35;
	Tue, 28 Oct 2025 23:21:26 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 363DF1400C8;
	Tue, 28 Oct 2025 23:23:10 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Oct
 2025 15:23:09 +0000
Date: Tue, 28 Oct 2025 15:23:08 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Alok Tiwari <alok.a.tiwari@oracle.com>, <linux-cxl@vger.kernel.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl: fix typos in cdat.c comments
Message-ID: <20251028152308.00001730@huawei.com>
In-Reply-To: <39194f34-1434-49e2-8d7f-22bcbe9be2c6@intel.com>
References: <20251011183050.616325-1-alok.a.tiwari@oracle.com>
	<39194f34-1434-49e2-8d7f-22bcbe9be2c6@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 13 Oct 2025 11:53:35 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 10/11/25 11:30 AM, Alok Tiwari wrote:
> > - Corrected spelling of "bandwdith" -> "bandwidth"
> > - Fixed "wht" -> "with"
> > 
> > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>  
> 
> thank you
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
FWIW,

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
