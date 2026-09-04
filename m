Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D43B1006
	for <linux-cxl@vger.kernel.org>; Fri,  4 Sep 2026 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788491839; cv=fail; b=NQPysAvu6zvFDnyU9guRsz5VV0C9oWX1jPLslX3QvkpQqUFEaB3YehhEKRf+JcdiYDc94/ovT+H5NspJjC/XlXZ/ZdhQm4f5tSO51jS04Awtxdd6JR/RVb8CXqJdn9EbILw5BSlleiqUpt2QMqD6KxosEaYa/ZfFUbBW3kshlN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788491839; c=relaxed/simple;
	bh=5cKg0mi02v7j3pvybzZbKr7CxLVdRiSSYr87vNAldzA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HEbTAYD4iEHkQmHTw5vOZ2PTkJN0jtxzWN9qIhalDNZthygM2T8eQ/3e9jht5EpcUYL2DHxRNEYYApBAmEuXt37lxKTEisKu72sylF5+uNeGkmC1Y3tc0MabPHosATqGHVRUb0gZID4Q7pEROu2mnHDTrTgqA7YpskBlUCUQo94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daKQoHmT; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daKQoHmT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788491837; x=1820027837;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5cKg0mi02v7j3pvybzZbKr7CxLVdRiSSYr87vNAldzA=;
  b=daKQoHmTwcMfTueE1xHExGzGqddRqrzk6Le66zN2kNQZmAuPD5GI1Ray
   FBbBcD1dV9NLOc/HHNg05U463ZkFtAMOc2ePJUnHXWyfR0RWv+pypmZSL
   7wTXySJqUh6Rh9Tprp74AVNis4ztg7DL8ccZZHzb7pcKrehIsUJN4NlL0
   kVZwD8qV5jCgWM7lXEzgSU+/2BknNPDdbM3qkxTtRTImaoMhRrHHgPk6O
   wxw/IZ+LwdSN0j3S5AUiZqA4m/F8JBJGOfu54h7b0gl9vZpG3GwE/Di0m
   rU8yHEW/XoaVYiYSE/5RKHhubD4B7EpuJaVxaRmoQ3WSOAWK7oCEiCIrJ
   g==;
X-CSE-ConnectionGUID: fTcn9tqAQwC+c3DKhmY5YQ==
X-CSE-MsgGUID: 0iK+UdBARRyKk1h5tCQTpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100149203"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="100149203"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:17:17 -0700
X-CSE-ConnectionGUID: 6ZWKxbfHScq9cJwdkFZnFQ==
X-CSE-MsgGUID: d1AFhvXJQy6LanGEDl6wiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268605894"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 20:17:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 20:17:16 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 3 Sep 2026 20:17:16 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.18) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 20:17:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA51zQaLzckDdpM5SU+nL1LYSJdlpDZZVNGlntRkXzcGxZZUCVzvV44FNNy80i0oWxTOXBs+ZXIKYzZltmeeZLa0076YXO2FK2AVoJYsxVjztsfMmw+QW5oUPfmPtBbPhGL/6FdVSdVeTHmp53pLNDelBl7OybYRMUI7q+kiJcq7oVsgFbVxBsC/49Hz2AtKKYu90fXGFYCNCgVExh3bqzUgUl9c9fLAn88326O4tUeK5n8af0T80oz1zHTn2DQCQ/cXJheMgKmGsOEG43D8j6ivcQ8DCU7iOaMdLMwsp8XFP+cVqf/2PjM9rtPLFPuDwGTW8fCswtcbomdSUYligQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61tURr3jjYhGOG0ZL0W78Bv2vQ2hda1hmG/xYfqx4cQ=;
 b=G08F0XN4wPdP/Rudd5l1/cCBi59GV9MsCRzXDFp6zOP2Rj5GuydOUDzSm6Ik1g6NlJ2pHNPDMmFqCHOR3JstVwYI6v8Ut0yPqft+BOgcRSGaG3/vfVFLfJQqVsXAA+nxMetwgKjgJTL8vl+fz7Zs+SSZ1r31iRdMDfslWiLmieOacknpkW/TuqclceD5rd7fF5yKsBxBmkbydt6hjbO/4vfLQ6Vl6FawfoVoyIjDqeYGuStrGh+OZrVZ5vBCwwl0zCpo6//jagUmHksbJzvQZzZHcudvMABfzjs8Cr47/2mGuTkWcpfsaOwd+x08FwG3eAFWrQL8l8NlIr9sNWsxQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH8PR11MB6659.namprd11.prod.outlook.com (2603:10b6:510:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Fri, 4 Sep
 2026 03:17:08 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 03:17:08 +0000
Date: Thu, 3 Sep 2026 20:17:04 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/2] cxl/region: Allow passthrough decoders with >16K
 granularity
Message-ID: <apo4MPeJkMSvPOqy@aschofie-mobl2.lan>
References: <cover.1784940306.git.alison.schofield@intel.com>
 <5b1f9970140ad1ea5924de06b7e6879e3b9deea1.1784940306.git.alison.schofield@intel.com>
 <amxHLqcwROvNP6Mz@MWDK4CY14F>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amxHLqcwROvNP6Mz@MWDK4CY14F>
X-ClientProxiedBy: SJ0PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH8PR11MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: cd46424c-0b99-4baf-22a6-08df0a3300c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10067099003|22082099003|11063799006|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: oq0qhNnB1DLlor9TlLk/IaBrCDlNEI9+4d3+rAKp49LVj1leuJrevDDx5PBFWXDAFbJDHnZtAefMgK1o66yIKziR3nNjLOQVL++10XsenYMWnbKdPvy1EJBhR9/xXa7W+a27iAd4xeiDhfMUk5QfA1d3dlIT6d13qpNOXFEleDolZ53nOgIxPmHsPwY8FEhDxvmVghv+Wfsum7/bfLUu34Mi1h2VDzNQ/fhZIz9k4aSFNOoBTddYdJ18DjD5WXbBoUCZpWjhVNGGyyK795DRXagdGQL8/IBEgbyKF8UdCSq9JC5icrjKMHMpss+yoCsFmlkHhC51lUD+h5FbpC+j4XqJpLmGdHh9Dopfls69kzcjvHvIKs/GVfF/l/5YUlLUPefCjbJ/UnziICy9y8FILpK5Mqo2YIwXovQV5O6DU6ZYaN8zvl4hehOr9bM3O2CFU1wmoan26HvYpr3ikrWMta8Pb88zAG5gYVxP6zLVfCTU2lP2CK7CkzMqlL6ERQ++lRh5EG6W55g9YAJigq5Tb9k/NuDACrgzFUQC+KqxJPEjlp2jmly0WKmMdDNfzSeFTQgclrj2IMCHGc0zLv7HksjSqYIbAuwhTjgYsFcs3a5QWEc59z2p9NRr8quc6B48d1B9OLGg+bSHs9aN+tDfR5lk8FD7obyl491dqvDTQnM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(11063799006)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0foiQ65+G6KIfOa1YW7CFsshcLMx6oLU9Qtv2QIg5jAUb25aaARyWIAlpn5v?=
 =?us-ascii?Q?+JpLB/aCeYNctavN5C/NBl9I/P7o2f/9bnNBRRKmZOXg9fbbUxqr8kADG8Iz?=
 =?us-ascii?Q?trkmrdtx5LWO0MNMI8ANyvR4C2MirlbIhmiGx+ubxrJDJ3zngHc55rcWRVjt?=
 =?us-ascii?Q?OFWSfk2KwCSvM29s2SFSp47+CnvcTZbcOJybPKo8PiUu7dqudcyQenfvOtTN?=
 =?us-ascii?Q?q/Y+gBnXkbqL55Vtliwg1DETM+wgJvR3GczJam9BfgAoMD8TXRKpcXAlm5EW?=
 =?us-ascii?Q?Z2FK8RBw4HXjxzecSVBKpAANlxnXjNEnap+/o1ERKeN38vAq5XRLRP8QntxT?=
 =?us-ascii?Q?SmuTvvM4byMJ+bR5RZTogXNZvudil3/w5gsrVPHPjfaw02lNBrsY1kDfdm0m?=
 =?us-ascii?Q?Q/oAsk6U3oR8spxA39y7QW7m5rkkeZW5vH+3oev2vSVrdS9cbB2xb/EpsnnC?=
 =?us-ascii?Q?xyD2zv2xOntI92L2dawEk/qdkWrhBkW3tjTtqMYSHNbkD7Di0CgEKbqO2jqV?=
 =?us-ascii?Q?o3CzFgkofhkF+IuklrLR94u9dcZGANdB/h1PZjO/RlmNfGXs0gTdvlcrWK2U?=
 =?us-ascii?Q?O3TBCtZqrRVbqhsRllWy23E99Ows8WScICOsG8Z0C7sxSuScdp/YLIOqMjph?=
 =?us-ascii?Q?EDczyDhuUFjj+/xydJE2CI3580NGND+T/rzsfgWIOVaAEuac0TpsfChhxOGN?=
 =?us-ascii?Q?I4Htw43A3JVCpNf8ub72vyYwM5DjZ4KpZukkvzaj5bYobNLXi5w2BtAbGIG9?=
 =?us-ascii?Q?RAr5uU9XgUPz/zl2W1Rxa9fc6pt1gqsg5PmHLNsByazLYdFX72Ot3JW9xypd?=
 =?us-ascii?Q?HXBpU0QFKoUSMpsPhfr72NbxIS6JZcmuMWZnv3NS9xlbLTIdZZQIRhPPb20w?=
 =?us-ascii?Q?8oYYi41Ur+PK5YmPsV006WHo6wIRVCgVPBS4IFgZm7iojiF3RCNL11JsPDFu?=
 =?us-ascii?Q?0cRrgej798r15V5XMX1bhtjOu94AFyaiqJa8v7whZKyQYbyHud6GYbXktNkB?=
 =?us-ascii?Q?BT3nozcw7qChcK96BGTHrUGR87fkL998IsvSt8EeNfzdmVQ2k8xOhRrh6qeZ?=
 =?us-ascii?Q?S4TDqVzzwlsDK3dpjNvZUQXt0k7OsgWekaAPY9DJkuG3tLmKciXHwJIIjF1r?=
 =?us-ascii?Q?w04KKzc31eA7C9V3tdfHknrljvu+vKJJEATBSuJlFmvXFGUrZESGSrZzWba2?=
 =?us-ascii?Q?ZKiviAeGtQ/HP6QJD2LK/onREjaRbLgt5Ja/wJCGOUBELCra8A7vZQcn/8PC?=
 =?us-ascii?Q?IMTUQq+cb4sm0+rEktVNJUVRWw4gWo6USqanZ5DARoIGlQWjdec4ahl4wJRT?=
 =?us-ascii?Q?4enywWCpJzRprndZRl/iHNKURzXSh9Yd/6al0xwYhDdDEM/ArIjJld39jWEx?=
 =?us-ascii?Q?TGE8U7stflX4ArL+30vbdb/ijbwJko0oW06kkiWZha9/qY+OjqVav7nJT2BO?=
 =?us-ascii?Q?fGAGYjFwjKTUKINn9lbLe8o8SrrY41ItTwxgV3mn6OwoWcsnNT6iAuLq32Xl?=
 =?us-ascii?Q?xqznTaynwwRWm35fJFta8sh1zqUFsz1FFxL8lllpHURJVN6fscC8gkiDKnW8?=
 =?us-ascii?Q?JM9AjImdlhn8gjmDrwp3LSF8rHETQCPFTvCwnhmPmpRQAcJCTflEnqVSuUz2?=
 =?us-ascii?Q?XB3NXYvimtGdf3VXkeCvczQHTtClA4xr0yvQRHGcYhoZTpr9tPkPhYgCFT3X?=
 =?us-ascii?Q?LUgMulc8EUWXy1aBOloW57tYlhcc0x0rAKX/y4digexUKQgqRMrc0EQjqWM2?=
 =?us-ascii?Q?DO9bFt+ts8VMtoytYTGQxDnoxwIb99Q=3D?=
X-Exchange-RoutingPolicyChecked: aQipGJQ6SNxNTOKNSDEKaYZq5qf4wb5YUll8ifkFYmYPnrEzdDR3uSBjJGqU+fiLQQxWFZi8ommTnwhPkG/ZOoaVliuE6S2PXZxg7NArJ6Ah/LE4EFad19jImUgmSJX1T1xTCbBTcJsrOZ2xUtAn9D6z8k2GM07qFWErS1vngeYZfEA5AX+G0uoEB+rUOLDl/EfLekxcGAxD51yCFH6PCyD2aRc2jqj2EOpX4nPgB3yuF2aTdUcTDucM4jeesPNIzO5mp4CNwgP7+UedY+t5gGjWpZqTGT3SuQko+OUNdARjoZr8qJz1rdXVK8M0TLw5m/lLM/x3WUvZ3DByPPpMmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd46424c-0b99-4baf-22a6-08df0a3300c9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 03:17:08.4507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8VGA5sxh1xeu5TUeK2ppRkoLWymY2SwL+kpHb0RQaooljKRDJEv/M7aqy6wXqFWw/9Ekom5nrDvr7ReBr63T94uH+WYISvIrz6ouEqmfUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6659
X-OriginatorOrg: intel.com

On Fri, Jul 31, 2026 at 03:41:54PM +0800, Richard Cheng wrote:
> On Fri, Jul 24, 2026 at 06:08:54PM +0800, Alison Schofield wrote:

snip

> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b6..5a443551288c 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1521,12 +1521,20 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		parent_iw = parent_cxld->interleave_ways;
> >  	}
> >  
> > -	rc = granularity_to_eig(parent_ig, &peig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> > -			dev_name(parent_port->uport_dev),
> > -			dev_name(&parent_port->dev), parent_ig);
> > -		return rc;
> > +	/*
> > +	 * A non-interleaving parent does not encode its granularity, so its
> > +	 * stored value may exceed the maximum encodable and need not be
> > +	 * validated here.
> > +	 */
> > +	if (parent_iw > 1) {
> > +		rc = granularity_to_eig(parent_ig, &peig);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s:%s: invalid parent granularity: %d\n",
> > +				dev_name(parent_port->uport_dev),
> > +				dev_name(&parent_port->dev), parent_ig);
> > +			return rc;
> > +		}
> >  	}
> >  
> >  	rc = ways_to_eiw(parent_iw, &peiw);
> > @@ -1549,20 +1557,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  	 * Interleave granularity is a multiple of @parent_port granularity.
> >  	 * Multiplier is the parent port interleave ways.
> >  	 */
> > -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev,
> > -			"%s: invalid granularity calculation (%d * %d)\n",
> > -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> > -		return rc;
> > -	}
> > +	ig = parent_ig * parent_iw;
> >  
> > -	rc = eig_to_granularity(eig, &ig);
> > -	if (rc) {
> > -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> > -			dev_name(port->uport_dev), dev_name(&port->dev),
> > -			256 << eig);
> > -		return rc;
> > +	/*
> > +	 * Keep the computed granularity for descendant setup. Only
> > +	 * interleaving decoders require an encodable granularity.
> > +	 */
> > +	if (iw > 1) {
> > +		rc = granularity_to_eig(ig, &eig);
> > +		if (rc) {
> > +			dev_dbg(&cxlr->dev,
> > +				"%s: invalid granularity calculation (%d * %d)\n",
> > +				dev_name(&parent_port->dev), parent_ig,
> > +				parent_iw);
> > +			return rc;
> > +		}
> >  	}
> >
> 
> Hi Alison,
> 
> Looks sane to me, just that this check pattern appears twice and peig
> and eig are both write-only afterwards.
> Could they be formed into a helper or macro ?
> 
> Something like the following might do ?
> """
> static bool granularity_is_encodable(int ways, int granularity)
> {
>     u16 eig;
>     if (ways <= 1)
>         return true;
> 
>     return granularity_to_eig(granularity, &eig) == 0;
> }
> 
> if (!granularity_is_encodable(parent_iw, parent_ig) {
>     dev_dbg();
>     return -EINVAL;
> }
> """
> 
> Reviewed-by: Richard Cheng <icheng@nvidia.com>


Thanks Richard!
I took the helper but wrote it to return an errno rather than a bool
because it seemed that a bool would answer true for any gran at all
when ways is 1.

Went w the style of the other check_*() helpers in region.c that return
errno.

Please take a look in v4.

-- Alison


> 
> Best regards,
> Richard Cheng.
> 
> >  	if (iw > 8 || iw > cxlsd->nr_targets) {
> > -- 
> > 2.37.3
> > 
> > 
