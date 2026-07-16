Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3904B335067
	for <linux-cxl@vger.kernel.org>; Thu, 16 Jul 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191303; cv=fail; b=gplHWk6h1r8JAticlvqWEZT59WXuwShZUnUq/eY2D/AyyVw+GGnib6uQ7bgLi39xNtylSmfwlWemvZZW1VxHBe60NBjOKirj7yaRZlw7jzad6r+sY4VV8CgkvTT1KYiYE90Wy5przPG+u9BcR7wH7ZE10KoLcMsMlfn+P9dV7TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191303; c=relaxed/simple;
	bh=8qB0Rfh5l0gDeXyWWnkj0CA+ShFfe859ilOXIhWZ3h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C6tqhaCBAe/RDbp/BV2d7on+cm+obVnQngXgfYF4aqRCqsf9Nv1m4MkSE6yNWPKU8Sq1/zWGHDO1cz2M8cRDpitcrY+lNZZ8S+iVkBNINhZU8jQ6VFkisdxLt1JHtq3Da3Uyqp0wi0VDotDeveJLeqmHWDRyD6X6EqdSTtyw3wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sQJVtkEK reason="signature verification failed"; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sQJVtkEK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqWflI2sliZASLyciPHSpS59BPXE+7p8YXHczV9S85l7Dcq0ZFHdqbT1RRuJOyc2zLsyu95j6bdfjEdaPdPgOpHMp4Hfi1Rtpi4vC1UvyeOBxXY7d15qmudDCKBDJxzZfX3t2KRd6FjvFlA7pmTfluqxtqnM3kAkxdmxGzedOXNlXwYm5kaIa1msFjigOA1XAUeqk3fKpi93qWMn2kFxlN+uIwV7McTUGj58IDptURWy6mStd+OcDJu/2pYrMFAdlMNjG9OPPZZsO+poiKcmhN+ShK5hvZH1bN+An7OIk4Hkp/9DxAzVYCaTdWe5tU1aY4huIq0n7+8FPWLVcl48yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1TP2U98ammw80ZzunFG154yyymdJ7C5EbVDBlc84+Q=;
 b=POiUPMJ6Ng2zb47Rh2E13KnigUW2MlvmY6x4BR+zpqF+G3Ib9BnXXEpTwRTehtriOBpH7nux48UVIX5gSbxO3+AUoryaZ2MT5s5V4hhStsBaCDgPZLfSTYvGR/H/9K4t6+pnhXgqJOMnKkRKKT9wWSGXm9h0hOPB0qws8vQ7fyk8ugrOBXWsp8eWSB/6mK4tnIsD9vQDt2kgJ8xHwtnhd+mGYgdM2TmHxha2UT5yV6k3ow36jdPNCvDqwqhX+w3+n70Rbpc9LlC2MTRNtYa1L9dMPRSl1Vg8IuiE++0pwSy9URG9bFr57IRkM3UroRdrNGEnMBgAeqtubhFoZHhdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1TP2U98ammw80ZzunFG154yyymdJ7C5EbVDBlc84+Q=;
 b=sQJVtkEKquh69x38sXZv/y7UT+Bjwz/7pCZuCdO3022PZD1C1l/8S/eN1agDt3MaAOVuDJ9N0SVtwvcKfrP1auJG6dtmwwlECIyf0jJd64O4BcHR2HFD0gns7gQnOu3Km2GuoFZ8FR+vIpseG6cx3UJCG8XEnsonyb+0rrxrwqY81N2XpEUHXCVeo31dSrqdvCa2JSiGU3dCbeA8CoLXpFXgb4TULayR2qY+0BdBMgMzLXT9+h/q6eII/q2HCqQixvkYQ5PyGwAvkjrmqDWlFXKicNVrd5HwiAf7IEMMDEXaX2bMALosg0cbJ98KETeXT9rFFqQC+r8O6SkktD7zxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS4PR12MB9796.namprd12.prod.outlook.com (2603:10b6:8:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 08:41:36 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 08:41:35 +0000
Date: Thu, 16 Jul 2026 16:41:30 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alison Schofield <alison.schofield@intel.com>, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cxl/hdm: Restore commit_end when decoder
 enumeration fails
Message-ID: <aliYaE7AMyHfF791@MWDK4CY14F>
References: <cover.1784150131.git.alison.schofield@intel.com>
 <563095ff87e66b72651c15248a1a6dd6f5ddc3b5.1784150131.git.alison.schofield@intel.com>
 <20260715215706.A76341F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715215706.A76341F000E9@smtp.kernel.org>
X-ClientProxiedBy: TPYP295CA0025.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::15) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS4PR12MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 92896b62-a330-4f27-f539-08dee3160b7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|4143699003|3023799007|6133799003|10067099003|5023799004|56012099006|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	2dUUN1NW4Dzh6EomLPlkAn+VtO2wmSU2t6Ulac/U5d9bU1gi5MKNQMGdiGdsHVcE1vFbh50duVeztN73sC9tI/ZOK63F5A0Etnj9RmubdUwXjTIapog2CSHxj7Rxjv1v8+klAZTizjuKZ2IINE8kDRpWlrKHH6vSnwbbksxjsXOYaHMv+gRtnscIXJ4b8cQWGdr63jhPokbbz4HoHDfVaN7UBbIru+V8mhAHikzV+UdhCNt1xRQwBAyPyDofgk867qKP8QYI2KUX3mNR1pHEAGE++qBB/Izal5IX8jJ1Uel72HSCuRQU1QZHtyeiM9PLxXQJNMLNKI2fwl2Y+T18adBzyEMLldVI/Z46xW3a9f+XPaK5/WrAO3R/7YJ4qCKARuYt+PuMIluaSUM1UANlCDloQd7gQG6M0L9az9lz0H4v3uHKIYAajIIQAMb+AfLsUlPHEAFRahM1xV69GsNd1lcqF88yIBOQI7Fqj4DKeNNNrmD7Y/zrGNd0T2NhnEClHNO35ILtdMoadotpE/IXIXgFRWE1bt1qgqXUkBVEfogkCXd3qKbcvMvnuNMLsW9otKX4IXxjy/hL8hF69Tl1XAn1FLRVH0mO2ELNVo2BHQH8r3R0/mWBOBtnpTPJ7DFOmdbjutGqb3kS62KdFRTdhJmH2MJOOqA6gSIOMVxGQ+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(3023799007)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Yrc5HVKo+YW9K7rj63TTdCM4GQHpNY5n1lFlgybEoOnLQJjASMdkEDuPdK?=
 =?iso-8859-1?Q?umVjV6EPkN4N7MNAxS2o7XB0slBZhpvfHya8rWPl6ak2x9iLdTAA0r9xS0?=
 =?iso-8859-1?Q?Mk2EAAVizKcdvbROwgCRKdIJ7CP+PG2SHJx2pm4eCvMHQkz6E6TE5LiXBp?=
 =?iso-8859-1?Q?fVY/lEXkXa5KH5tRPvOFPDcse8qDVPecDS/uGeSoVd7wRS9/TlpGPxxKxW?=
 =?iso-8859-1?Q?eh1LdbaaHIhEXZ69SazJkAHQvYnFOneQXDu9txm+RvLC6UfvDJUhAXOMGz?=
 =?iso-8859-1?Q?QV9RCg9XokOrMgX+G9QJA+0qcLxJWH7yDFd3UuHeQETG9JiK9TgcZztbyX?=
 =?iso-8859-1?Q?c6vkS3czxalLE18eSxFICQbiiAnPd35NR7g7HqZbeT3ID1EDsVzRO/JHs7?=
 =?iso-8859-1?Q?BWz96wgKt+2gPdZ3M9XBgs3VCNevcsg2ovczkTAe38Db0Zqi/DLJKvmkYf?=
 =?iso-8859-1?Q?BXfcu1LnpL7nNdYXOV31ITSNY3rwNvgJxRNiHmMNZHdfaQOX6LKPQpso4l?=
 =?iso-8859-1?Q?nvQwy8QIXPI6UgDBY7B31w4ZpMhlR+4NZrQXcjsvx+f0XwprOLGBKND5Vf?=
 =?iso-8859-1?Q?2cuihpq43l4AKdCSnkUF86IdNPWSDbrBWiIRyjCW4xkKdwjlT0tmcak8KL?=
 =?iso-8859-1?Q?uhQ4ZBYTQIlo5IFvd4QCrf92tSyS5q4iCtzXiY/gwKIYJrKH5+K9ciFlWS?=
 =?iso-8859-1?Q?v6uTFqm8aB7eOg2F/U0atWxkWxkDOrRIqiR1BQjRn7hV4PhMXfwd2RMYcW?=
 =?iso-8859-1?Q?8yAKjvLrihEJ9bF8QRIVXQ1XLIIXcXUSjaiRTj0fjUWaAScUoX+hhcWVGA?=
 =?iso-8859-1?Q?v7jG9LSDj7tTxyZhqEPyqsk4DcTddlTc7I7jBq27PZM1DDXmP5T4aDioH8?=
 =?iso-8859-1?Q?TrgXPy2v58fXfQTuaSKm7JpWVYUWElQpkZZF8ifRMTZ1pcOstIJPuXK/K6?=
 =?iso-8859-1?Q?0Pd9owTyyLzpX0hypsRJSHCwwBUxVvEHi4cAJ6OdnvjDRHrX8HC14gQx/B?=
 =?iso-8859-1?Q?JOFKsL46xT/GgBipjpthi7nX+rVcgEDRxo+/jUqUzTriutfpLq44vScve3?=
 =?iso-8859-1?Q?3R91tJEbVrTD4Qnek3MaLIoopjdPb55LHLph7TZgqxZfz9QR9b27QaRbtX?=
 =?iso-8859-1?Q?z460vF8WdlB+qkyoHV3alnIjZ/x1Mgn8q4tghHgyP+XEP8/wA5y47oquuX?=
 =?iso-8859-1?Q?lTqFl3+wg7/obEmNpYy+KOOPexrfv7rULir7nWaW30ask3Vxk32CHRRa43?=
 =?iso-8859-1?Q?yREIjDDGGr/bzngbuqtI2S0EDix1h7WG+2S9RE9rdC6Pl8ZUdfsBeuUayA?=
 =?iso-8859-1?Q?zOT47r7hI67j0aRYHJLm5WAsA9vaESdC/miRmYZfxBAK3seP3MbHTqRf/Y?=
 =?iso-8859-1?Q?us98fYfAjNa2Ed/eLk9+0faQ0Fxgij0Ttqmk0dn//ciAi/eK9ugwCKTjRq?=
 =?iso-8859-1?Q?q+D7gFoeKcnV0Bqqa/IH9F9vcKCoRgK7uzZH8CMy7ifnE8JhdIoW8R6Hua?=
 =?iso-8859-1?Q?9ZMSeGMMWUvL+BV2HYC7j6iyuADDAbDb6xLu9LtgTF6WOMvoqNmMPCNKF/?=
 =?iso-8859-1?Q?jukNkCJ3dMY+tiqDU2s8T++9nMZv0gywK5kRS3HvlEaZbKkEiA/2kDRGJ1?=
 =?iso-8859-1?Q?+Zz9qDAUqGLIoAA1e+Bhk8YNJf7HsO6cgY2KrF0xSKHleFnj02lYp8AUoJ?=
 =?iso-8859-1?Q?+LUiaTjs+J9pkfOtpoIwgEUWHdcKyfu/qlR5S5kcSs3XvBecp9PyS1mI9c?=
 =?iso-8859-1?Q?qEGhrn+5Kd/qlvrx4Cj6kHZsiVUWACH5W0KfeijLWeh/Yv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92896b62-a330-4f27-f539-08dee3160b7c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:41:35.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIfxlI/ui4YePnbXPvUgo7erj4Wa36JepP1NJV9bFvo/2Ih+FXuLzpQAHh/PD24uLfTlKvo5dKyYTgCuMW7Nlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9796

On Wed, Jul 15, 2026 at 09:57:06PM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Mixing goto-based error handling with scope-based cleanup helpers (`scoped_guard()`) in the same function.
> --
> 
> --- Patch [3]: [PATCH v2 3/3] cxl/hdm: Restore commit_end when decoder enumeration fails ---
> commit fee00b887a5dc8f3c4c335d03db77d2ecce10947
> Author: Alison Schofield <alison.schofield@intel.com>
> 
> cxl/hdm: Restore commit_end when decoder enumeration fails
> 
> This commit restores commit_end to the none-committed baseline on the
> enumeration failure path so a subsequent probe can enumerate cleanly. It
> also protects the commit_end advance against concurrent readers in the
> DVSEC emulation path.
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> 
> [ ... ]
> 
> > @@ -1198,7 +1199,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >  				dev_warn(&port->dev,
> >  					 "Failed to allocate decoder%d.%d\n",
> >  					 port->id, i);
> > -				return PTR_ERR(cxled);
> > +				rc = PTR_ERR(cxled);
> > +				goto err;
> 
> [ ... ]
> 
> > @@ -1220,17 +1223,23 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
> >  				 "Failed to initialize decoder%d.%d\n",
> >  				 port->id, i);
> >  			put_device(&cxld->dev);
> > -			return rc;
> > +			goto err;
> >  		}
> >  		rc = add_hdm_decoder(port, cxld);
> >  		if (rc) {
> >  			dev_warn(&port->dev,
> >  				 "Failed to add decoder%d.%d\n", port->id, i);
> > -			return rc;
> > +			goto err;
> >  		}
> >  	}
> >  
> >  	return 0;
> > +
> > +err:
> > +	/* Reset to the none committed baseline for a fresh enumeration */
> > +	scoped_guard(rwsem_write, &cxl_rwsem.region)
> > +		port->commit_end = -1;
> > +	return rc;
> >  }
> 
> [Severity: Medium]
> Does mixing goto-based error handling with scope-based cleanup helpers
> (scoped_guard) in the same function violate the cleanup subsystem guidelines?
> 
> The documentation in include/linux/cleanup.h notes that usage of "goto"
> and cleanup helpers should never be mixed in the same function, because it
> creates confusing ownership semantics and can lead to bugs under future
> modifications.
> 
> Should devm_cxl_enumerate_decoders() either be converted entirely to
> scope-based cleanup, or avoid using scoped_guard() in the error path?
>

Hi Alison,

I think this finding is real, at this point, decoder added by earlier loop
iterations are still registered until the caller's devres unwind runs.

So resetting commit_end here will create a window where those enable decoder
objects are still visible, but cxl_num_decoders_committed() tell us it's 0 there.

I think the commit_end reset should be ordered after the registered decoder are removed.

--Richard
 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1784150131.git.alison.schofield@intel.com?part=3
> 
