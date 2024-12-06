Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C5193060
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463134; cv=fail; b=c9g95Zme7Y1G52ZeknwBChGQIDM8YQThuVXQHfv/Iv8fWM6fywCZsuHWeSlsoZJYuMmPxJ1yagmtXzGMYns9bR3gj593FQyJnlNWhOocrdfmmCoNk4PTfI5eg/uxkm3WVYtIsqF0fj9zPbF6VkA9t6/phkTzJpcbtEXgH5Fb93Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463134; c=relaxed/simple;
	bh=UCn8qmgPsdZWelbDylfKMhOpHs6PT4tvT88lTnAWlZw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u2/aOkCc0/1RpyFc4lOLAaL276uSlSEUP6mnrhZaw76yTgpomX6jtt5ZXYjXvpdXFvF4aM5c9dst2vhGV3181t4uXG/5QgmPY9vhlq6SE5B63KBg6AGHclZs42eh5YFDWjrTnUhKoctgh8JWmtnKVOR4IiWEd0QHzf4TggzylHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFPg0wUd; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFPg0wUd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733463133; x=1764999133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UCn8qmgPsdZWelbDylfKMhOpHs6PT4tvT88lTnAWlZw=;
  b=WFPg0wUdgHCp9JkFpxmTgOhGbZhhZJ0TnxoMSbw2fcsKzSIPOK8syVMA
   fNPKaUrGZINRqI3evbYJ9YgafnWap0x65BmOjZQVcV98qbRjyfrgXGFcU
   lAvTFlsJ/7HFmpK+P38wvayFK365YfdhmZj8O+Z9SNZhXYsYGxS7XB4WD
   cGivD7mq7Q+OtYPfUlWO37husmXuhanfKRqEpY37m3BpD1cC1x1Q5WZRu
   striEujIlvszEijIed807xp9W3312XnCL1sGYqgtMteKnAAYPeZYVqcDz
   VjYO+MrlouVw1ok1E2pupW6Y0GBXib2RCYSs34h9Bo2mI3mDYg9HFcorr
   w==;
X-CSE-ConnectionGUID: N4OVfX8aT8Sb+GnavDbOVg==
X-CSE-MsgGUID: RnEIS9v2RBS4mbehHw8rPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44476040"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="44476040"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 21:32:12 -0800
X-CSE-ConnectionGUID: NNJLhVbZSSS+VdMuWx5N2A==
X-CSE-MsgGUID: 1Uwp7j/wS8OSusARmQdtfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="117559275"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 21:32:12 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 21:32:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 21:32:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 21:32:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJUXyNxDLvqMij3XUNqyekhGX/GW4Sin1nQ79c7RAmGatSVwwAwaVpXqPsHMkh1dsZI9v9hnxaqAZpx5RZ9OCcene93F3Udai2waQTuUCLCvRJ1XL3pOftcN1i9vbgEpoOAuURXVNsV8oTuGwj2g8qY+33nJXnd8FVvC/091NP8XI7o0VA8l5vuV4/3uhuQndwpc46VKbRr/XmpmzDAgILqa5b8rjlff3Hav9TZBWBcoERL30bRBHECFngf+yS83oe/OTU6g1zzSaj2SyWsZAPuLk6KGghmvGp5JLFKaJIBj12dRrvT/TkUX5rne06mG06L4IcfQxmdSf+ESVFdd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCn8qmgPsdZWelbDylfKMhOpHs6PT4tvT88lTnAWlZw=;
 b=Q1jrp+t6qC6d+PKBFc+JEGpBOxUXCp1y9snplSpP1PdcT40vRLA+E7hBS4wq17Fhvh9tJ0pL3abp+n7ab3yM/WGoNHwJaTF40w5oZaWZ1ZaxTNI1uKmFqvnhLJw/FrSgmeyozGbBYgZQM4H6Wk9m4JtovtfEsgv22YBYI0JAbdd8AsdEquBt+uqQv3VWCxTqVKg4doxLNxSLCaNj8Z5lOoO2tOzRyrECEoxpWDPRkHNoyPKPWefyguHhS3B2f0JFY7jk4NnMnOi73OLMBmvNtzVPh9yg1dFBCAin5SflfDMLCRW+sZWjzN0rtMjds1mRAYTtOlnE02/U9tmZCo4VHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7465.namprd11.prod.outlook.com (2603:10b6:806:34e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Fri, 6 Dec
 2024 05:32:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 05:32:09 +0000
Date: Thu, 5 Dec 2024 21:32:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 11/20] fwctl: FWCTL_HW_INFO to return hardware
 information
Message-ID: <67528c573b189_25073294db@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-12-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-12-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7465:EE_
X-MS-Office365-Filtering-Correlation-Id: ad122cf5-9530-48b8-d567-08dd15b75440
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aa+OnWcOtOiMQ9kxHkXM1w32RY/ZFsx3Mz8ik8pWx+EolQP+MkVTtAa29d/m?=
 =?us-ascii?Q?9masX/Q5ECqVIlCJOUYgqptStFyFDrJUlLLoOjTeCqYeh6WqcpInepbTuty6?=
 =?us-ascii?Q?mp6y/3jQ6GVNMHwhZs7DrYJaeqRMtRwn1muSWmyUCcoeMeMMbxJtww5IdCxy?=
 =?us-ascii?Q?O5jgdmAP3LnIOncqVb+pzsbjh25OOk0/t2OJyABJFQMAGMvNoY3lKYruqE2y?=
 =?us-ascii?Q?TSvhWAUGhE69vqHbiZjxD2jroCguajiqGRwL2TgDwSS/R6j+fZXyJz0eG2+k?=
 =?us-ascii?Q?DbURcGyNapcfZxMc1OxXAtJkNvuGkpFcopiINLGpGVndIuTqT0OpbTu0oyQS?=
 =?us-ascii?Q?i3RdXetyvnt2o6n2iOat9/1Lcu9TFvQGTo5CfoLPOMR3OL6SePVuiipu+T/K?=
 =?us-ascii?Q?rloO7mTOne83PoEOiF3ogDjrpNQGCCAiK1Q/rFtZJmKoSFN0y+FeYZUJ2Kv4?=
 =?us-ascii?Q?TFA80BCaKfLhu44dbeF5BUr2qqtJJH5pnWBxdPVWuJykdm+3N89USnMHAcuC?=
 =?us-ascii?Q?wg90kjSGKnHFROMYieWLeITuhfSPZ8D+b2dLkRZSo6T28XchiHmgEHJsw5sW?=
 =?us-ascii?Q?+fWCP/8ZU4TBXP3LFdonO0l1iVD35CrTc8o8ZueHebB88iN5+yCKPe/nDm2V?=
 =?us-ascii?Q?7KSeP6IFbUVgHUJMabl/AYjnFgjCRpqkweRd52zmWvTgx6VU1TFClszAWFuX?=
 =?us-ascii?Q?qzBLIlNe1xt/FHioVRIXiI/GzxpzBh1vV2OMCoZ1YFoXInUvJolTQp7iTnR+?=
 =?us-ascii?Q?eeAm8uxiz2WuIRE4N24xrG8owsFT+TuLDZdxWWWjhAWtfM+HBX4Wr+agab0+?=
 =?us-ascii?Q?vVu61NU3udRHSA5re5en7VPZEz+n4YCfeGrWaSBelbcRyeVwcEeX0sMW3z/C?=
 =?us-ascii?Q?q/ZUtezw+JE7nPeqAieCQruVGR4rBN7N/ifnfZLo9Dq+2hoYMC8XnL7a2hr2?=
 =?us-ascii?Q?aFLLdro1bjCL1UTB9644s0ip7hvCHGhiGDlsR32Ln2wDJWGu7CQ2A8UTdpVK?=
 =?us-ascii?Q?RJSlNm+vGfsAi+hLACqQRLg+mvaynpINT/NDkjIoyiMSVtk6VGt5adKhQRyf?=
 =?us-ascii?Q?9AcGXczGkP7zzUoAlCfksceoW1nAz8C1Qj6xyl8GFHHCsNa2wejG/jbCeU2O?=
 =?us-ascii?Q?z8aQxJQbfxPDtQ966f+fdpabAWqr8HtgvYLx8EqIxVe/spOzG00LpzQAiUnE?=
 =?us-ascii?Q?fFFxmYMKzwsaZJ0uTq2Un8NVfXlFGeXAM0Ac666kjmTbIqPyEKND8qtXKBgX?=
 =?us-ascii?Q?QS4lb6BR4yu0oSqqpv2S1Gu1ryg6GMv7KWvtW6IkkDle2D42Ob9diJwdyDRX?=
 =?us-ascii?Q?iAn5rYtSxQP8VnfHbo+wk4yOro4Ecom4lNON9srtscMieg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WlApAI+ON8pdJdsXdywIX9wA5pA5jFIj/Z6xBv9lukAnQEvfnfH8qnXODtX2?=
 =?us-ascii?Q?3Dg8Jh6sqmGxJ1A9etLHSgoQ2GJ1y53a2gxCQEA3If0oftjfr5hEZUB/bXUa?=
 =?us-ascii?Q?d3uX84edmKHETlOSbrYWFDYWrfwElh1DcLyeDYLfynu8WVJZZi9VrwUXAX5Y?=
 =?us-ascii?Q?KIdyzqsJzWaF9P68IGDDfEf74uxXhwYCJcPsV0MHTXB/FQU14494zyVIiWfc?=
 =?us-ascii?Q?EDEhcrPj6Awv5zxv1f8S9xTdc6h0IIWXGHWlFA0VJSp4Sf/CQ+cQNLv60zIe?=
 =?us-ascii?Q?AZk9A32prvztB7/JDX4tV6kB8ZMXgOSpn0zaaYsoxRSKMOfmaMtFw4FuzL1E?=
 =?us-ascii?Q?H6XwD4QRGS6ISueM1WA7YiYyueEKDNQq9psNcH3x043THmoKeRziXOtWDGum?=
 =?us-ascii?Q?ZsWT7mEB/5cXovR4ebds+7V/9oLl8KiAWER4EZ9ZNQMsYH/zu/oGaoI6ShyP?=
 =?us-ascii?Q?GAXOeB9+8JDrNDy4iYu8zfKWG4Am0hisKdlP3h3t9waeGlckNHwi+6vzHmUw?=
 =?us-ascii?Q?vwN9z49rQFNpV/YC/2gtFLGxZPH7u6gnPyeTDa2mm02iHBYAFB74IYBLnNYQ?=
 =?us-ascii?Q?g4NePTGVlgAwxI7ewGiPXaBV1O1zDmvXRyK52sqH7fuZURWyX5fJjWSfQ94t?=
 =?us-ascii?Q?+H80x3S76D5DGW5T0L7FZ3Mt9agdCBZotT1jZzu4qLE62ZFCngnsvICpBcUl?=
 =?us-ascii?Q?F2376f+0qBc7YY6I2xGfmWZ/gEP8nvhShwduGoKCfFeOnQYEpCKiOrrmqgzA?=
 =?us-ascii?Q?e9gvSNuNI+nplA3GL4xgq3FGzDqkL7ZDWwuLY23gz3iDcz+bKngKygc0mqG6?=
 =?us-ascii?Q?2am0PL0QYFkURxKeQ5a9MoFgwu2T8lTP3qYYcx+AtdwfAcbibgdb0McsNVd/?=
 =?us-ascii?Q?tVpla1MMpmwjDaFPK7pBlg641L6l9eMqKTf0PuxUcjII+D46EcxDhbvCmaIq?=
 =?us-ascii?Q?DAiWJMnSBnuX4tXvnmzbvZg6ujtH3RrLmUsGrdlnctDl0oUqXh5ApgVY2gL5?=
 =?us-ascii?Q?Tap3CfscoVRreaKWNdWKFY21MuGZZPR/GeCwB71QwhIPCr+P7oMC23nGZCQz?=
 =?us-ascii?Q?At+ce4suw3oYGCdRbkHXEk8f3f716xcihHxkEfHfHuh6L11haSClkpQm900F?=
 =?us-ascii?Q?YnstDAyKLHhvPRrbqNRkAHwBRjqNn+NnXSNzfEsYHf4yKFQycPT2qHq0zgrO?=
 =?us-ascii?Q?ToZaVGSF9bauJdiZCgaBj4mKJUjyEYnfAsG7F/qZylasMijZ1mXOo2r2rJWI?=
 =?us-ascii?Q?e4bfTA/q5LybN/Nm0R4XNryu4UrRC9+Mh3uPexigHdifD9OsVVvNCiGH93Hj?=
 =?us-ascii?Q?v1gzMH8h/JmUu0nmzhGqOYKYhdyl2HM1RmGuQ4DojSoNXNUrhN9M7HjJsf+h?=
 =?us-ascii?Q?b5A5va4k/t/g4isvJWSqAtukypDPDcqECcDtXvejDsJ9eQzQ/4USLeclxmrF?=
 =?us-ascii?Q?niV9gyTdcD0Md6729yVAqcBq7T53M+1JcXipEFw9HymvAMEeuEdjdm9dsKUf?=
 =?us-ascii?Q?/S8eybup3cI3WJ5owavL6Kmh0Hx2jCXWZ7IDxEEY3IfREdG8UdCyoALiIs2f?=
 =?us-ascii?Q?dv8v6aREKVISVksZ8XgX8M+8WYMU2l0tUjkXieoqdYsdnflHPkXB4m1A6Pj8?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad122cf5-9530-48b8-d567-08dd15b75440
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 05:32:09.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ZIW+nDvtJyQ0+uBK6e8S3zY5WSC9XNl4mp0WY7rerhH7yWoAHPgDGdaYWexOqerJ11T5B/cH2bzM7/5N8+m28LKeah9Ewa5zz51HC3sIdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7465
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Add an optional ioctl FWCTL_HW_INFO to pass command specific information
> to user space. An array of 'struct fwctl_command_info' will be returned
> from the ioctl. These commands are send to the driver via FWCTL_RPC call.
> The command info struct contains the command id, the related hardware
> opcode, input and output size for the command, and the effects the command
> has if it's a write command.

Maybe this made more immediate sense to Jason, but I do not see why CXL
needs a FWCTL_CMD_HWINFO when FWCTL_CMD_RPC can just convey the GET
SUPPORTED FEATURES payload?

Now, if we ever want to support more commands outside FEATURES, I expect
that will need to look like synthetic "feature" that the driver
publishes to fit it into the existing paradigm.

In other words CXL tools are already going to need to have knowledge of
feature payload formats, why does fwctl need to package it up in another
form?

If, for example, I was looking to support GET TIMESTAMP over CXL fwctl,
which I am not, I would say that would be a synthetic Linux Kernel CXL
feature UUID that gets documented and synthesized and fwctl core is none
the wiser.
