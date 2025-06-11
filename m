Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E671E485
	for <linux-cxl@vger.kernel.org>; Wed, 11 Jun 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749648511; cv=none; b=cM4jw5MVtFm5GWdXTxZpTg06FpX13AQQCyIuFfG1Xsjh7csYZ6lsCHuwhmb3g7DDIHSeEmcxCoQOkhlhWVy4lreqV157dAB58aZY3K6Pe2TyfQ5Hyq7AojADHBT9aAWSNVhXdgbsGavJpMGCfdzfcvSkpUFZFstANFKFQGvmhXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749648511; c=relaxed/simple;
	bh=RDwlQdf1eEafK8mtxGbWjITe8tUdFD4urSmdKp5nyOA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLTJWySkk6KnH7I3ZWEvGyzw4tHZbSTCHmr9w1aih2hwbOBOyk79ylI68f6XZv3pT1tBa/8dte14mCCwUiT0/nd4RhjEqaiRew8ouFqXJ0FueBhS5B2O+6z3aHNfhQuS/pA2KCPFYYFpwqKZdEYleKDd1DqdPgJSWC5vjyK0lpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHRJT4B9kz6JB2N;
	Wed, 11 Jun 2025 21:26:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FD74140636;
	Wed, 11 Jun 2025 21:28:26 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Jun
 2025 15:28:25 +0200
Date: Wed, 11 Jun 2025 14:28:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: Dave Jiang <dave.jiang@intel.com>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Add comment about 'cxl_root_decoder' and flex
 array
Message-ID: <20250611142824.000068c1@huawei.com>
In-Reply-To: <e3d942a2-aa21-4195-8a2d-008236ea7276@zohomail.com>
References: <20250610175401.172660-1-dave.jiang@intel.com>
	<e3d942a2-aa21-4195-8a2d-008236ea7276@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Jun 2025 19:19:47 +0800
Li Ming <ming.li@zohomail.com> wrote:

> On 6/11/2025 1:54 AM, Dave Jiang wrote:
> > Add a warning comment for 'struct cxl_root_decoder' to not add members
> > after 'cxlsd' since 'cxlsd' has flex array at the end.
> >
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
> Reviewed-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Mind you this is pretty common and I thought we now had instrumentation
to catch if anyone broke this rule?  Maybe that project isn't quite
there yet.

> > ---
> >  drivers/cxl/cxl.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 9a17e8beca7a..68596e9216f3 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -445,6 +445,7 @@ struct cxl_root_decoder {
> >  	int qos_class;
> >  	const struct cxl_rd_ops *ops;
> >  	struct cxl_switch_decoder cxlsd;
> > +	/* DO NOT ADD AFTER THIS POINT, cxlsd has flex array component */
> >  };
> >  
> >  /*
> >
> > base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> > prerequisite-patch-id: 77982cd1ed494cf0f747ccf74c6b8949be9837d6  
> 
> 

