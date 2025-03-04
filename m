Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77889259C8F;
	Tue,  4 Mar 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103866; cv=fail; b=SiTM1RQaiktmzqHTB/ykyidnaHk3f8KnpHeRJ3l3kTvQptJuu1P8F5lXKSOSGFpLaTdZFZTXW7NOaWk6UFxVypka2OMkG20OBkTo8yZqgzzcUDPJzPstxXwMLvqZCO9CPPGvM4nRWZFF/2m9xA7Tlx1yqkAHoaJQEUuNfXnF49E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103866; c=relaxed/simple;
	bh=yVRFJDUlcnZRZbDxLqHPj9yq11B0JSJ+lEWJuY67/sg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WLyxMPT9ug+52Uicr39oEka7tirF3NXyObKpamMJ403AgfxyaF0b2t4aI46l0Wbw8SZ9rYXwvogIcR5Gt4+f/i5S8My0bCjpAnxYdLRhe/TW4t0xfjut7c9UjbeYWYtqBStVMpPF8nsEvwFvxSAAYz/HzdUiDUKc132NCxUi4gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EE3Cjx2w; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EE3Cjx2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741103864; x=1772639864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yVRFJDUlcnZRZbDxLqHPj9yq11B0JSJ+lEWJuY67/sg=;
  b=EE3Cjx2w4fVWmwXp5w63dGPiBs3fU0XWOXx+912jGrZo3vEO7biwwOLM
   JS3heucb6O6UPx6/P7+z3bb2Dbo9W3BvS69c02h7mW0NuMp5jjOwaPTI7
   Xlw6zYBBTOFZKouwXwCJN5nL4HQLUfvauPU+OY7vZ6etjtSQhN0dsyWNd
   egEe4DZQphI5kZ69uXkUXYvh968wGbajH4pCOzeIjRhmL3WHzO6u8uWL6
   MOZSbATJqTjwHwYdNjp+DhEY+9SDT8+lYhhVCaX4qcnVQLWv0uK/PcPHP
   5dqQe9/k73Qu0iBQWy+tZAZCDBqb1N2Sc/u1tWH4BHMMQaSOr9MPq0moP
   A==;
X-CSE-ConnectionGUID: 6pyA5ZrQRTKnht8fZNsc0g==
X-CSE-MsgGUID: G2WOeLLBTfaLYZaJtPoGqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42158208"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="42158208"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:57:44 -0800
X-CSE-ConnectionGUID: T5vT6SDGQ2qXZ/orPAG6qQ==
X-CSE-MsgGUID: tA98t5edTUe6O1n6ajXTBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118929826"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 07:57:44 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 07:57:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 07:57:43 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 07:57:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8mYBYoy7Rkt7p74ERqfz7tbg3xhjL+kzEwyysWm7gT8rqC1d/LoS1U4CzOUuPMQPcm7zLOl2O+hT3WmJVseW3s/KbX5XdazV3Tgw6ci4LYNY6ZaLnmlkLrpTSXHHmEKvycByyTBtnu6ARDyQAFImE++VTVF1kJ3yv+Dqd5B3CVNRjLZAoth0Rg+tWNltkVXGGjtsv2XoR3RWPg9h5KGop3RjoTho2X75OiBm4obaYV94Gvw3x6faZh3badrcriStapmW9a/2ZvxrxogqdjCVoEzjo1NIHzU3aPd0DAEbXzEftZEDLn+ZvxqOxOgnXWUKtD5IwYw3Lo+rRAFSt7HEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R23PPa4fOsqJG920N2oExEixYmvwPYhY/88/uYyNvpk=;
 b=n17ewJvnUpKekOSySNECJ3roa3vA7I5YcWA5AhwQsv32IQyoWWzKsiDWJ4fotJOq6KRGp1KzRHqX1Op8gIstHEq8UocJ3J85HdrHu0t9Z9AQXY97xcdY+URsRNuQysBUKUSQDSqdFlKK0nRKvF+wAC492DR1LXSo9z14dlWYP2TkvB81BmWs3ERR4LiOBNeOv73lpfWofcURYpUw2D40nX4JKeQeV6qj0VOYG73sPc9eMysuc9lzaREBAjXsE07fhw9Gw2J30mS2ZGv2qUkqpkzIx8qHkQ0aT18L1IgJRU4MX1x8qnv/BDD/siGE/r8FMl/OEgA/wpvXs5+HQqVkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 15:57:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%5]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 15:57:22 +0000
Date: Tue, 4 Mar 2025 09:57:30 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
	Fan Ni <fan.ni@samsung.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/Documentation: Remove 'mixed' from sysfs mode doc
Message-ID: <67c722ea4f375_1de84629460@iweiny-mobl.notmuch>
References: <20250224-remove-mixed-sysfs-v1-1-a329db313dac@intel.com>
 <20250304144151.000016c3@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250304144151.000016c3@huawei.com>
X-ClientProxiedBy: MW4PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:303:b7::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4847:EE_
X-MS-Office365-Filtering-Correlation-Id: 0172cc8f-4d34-47e6-af36-08dd5b354023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iWuZdfJUR1PVIXN14a4vJQD1YBWIt4mCLrZH/7tOJ6QLdS7ZeGPdi1Av22MS?=
 =?us-ascii?Q?NjoGK/7xrkEFP8r9dJPNtqvh1pLL5F906wln5xUUAJOdToDoqlkZRIPmQcbl?=
 =?us-ascii?Q?n/vbVYg4/TYME8EwZTjzYwzDlJGMWEv6zqfJiPp0fuBQ860sXrq5/HcrqP/c?=
 =?us-ascii?Q?H0hLdjl68bE0d0g6FO+Fp+ZZ1fLqjx6+C6zJSPbsz1vd/IPfOLcD2M4he+Vi?=
 =?us-ascii?Q?68drxSZzLPzbviRPqKxDrGMmglZDZQdO3MYP91lpvdlD/xdh+sA8HWl8R4Lm?=
 =?us-ascii?Q?s6X9ThdhuzYauHtff+zix68GY/YtGHkfGNa9QfrBVPGDRLVRF+Yen2lOlOM4?=
 =?us-ascii?Q?4nZmpIpfBatgljzAuJmbG6wwamd4j1iJZyIktq1cH0y3JdM/qxyjFpOmGSEH?=
 =?us-ascii?Q?BkYTNMtXal8jkDYVRtQk/GCaygPE75UG4A0BfpTG2EZuiz7g8HGOQ3G4kA+g?=
 =?us-ascii?Q?2DuVAil6mDNTudJLeq1928dDkO+6CqcmHDqWTTNqbBRvhCd6ejbtfmRvchH0?=
 =?us-ascii?Q?NN7LDpVLWw0KsUV7QHu5QeQJIITGauHyRIxooTxl5/hY+eCxrXpTD7N0XFPs?=
 =?us-ascii?Q?xIAInxu/sx0vx6YXtUThAFFoPcOTU5zYVPAQnudFapzMxNYfL1dPps1ENgfs?=
 =?us-ascii?Q?Du3ZfVFwn/dqHRYwCA6eRlQt2iqlOPo1V1GlJhKASV2Xx2gqIb3aSAhCjuf9?=
 =?us-ascii?Q?0kjUc8YEk12cmUML/90tq5DD2FoyYBO6XTYwekFzDSMRi35EIR98LhB4iIGf?=
 =?us-ascii?Q?HqA6vLqtGg5WD3LcaxKliMjaigCD60K45gxMHqBGAE8KEQIXDLq7qoomgCJG?=
 =?us-ascii?Q?a57dEHd+jqnjS7YlTQPrFxa+aDygZc+fNDzz8sJvvp86FIZFbPE/C8Ym2TQc?=
 =?us-ascii?Q?izKG6Y312mrB/wOThKpBv5epzigROxi20RZQuk+dcJ/uP+x+7piRgthkw/xB?=
 =?us-ascii?Q?FMnZx3tJ0SgonYEJdxBCCJZnmM9HU/cB446rkw1GndcJtsUVzFZ3b3Hq46B0?=
 =?us-ascii?Q?dvYgA0HKMRmPVNBi6hWpllC4Y6Jc/oLdaWTVbHsgn4aW7JWehN/3fa67wgN6?=
 =?us-ascii?Q?5Vm5UlTeFWnSbKCSEVKkpW31ovixyzfTBwwMTuINRRkmH+OR1TD7opquvxBg?=
 =?us-ascii?Q?dLwo+PQMbrVw/6ydZ2fJVDarYQ7A/dsUiT6hNUoBv2XxdL61o0YLLg3W4Jlg?=
 =?us-ascii?Q?BqHvjpZzVouEPHQzdS8BZd45EU268GgO5TOc8HL+M3jMk6SNLE8PHSZvAs5+?=
 =?us-ascii?Q?wLqGkvjiyWKySym2ygxMSa2V2o/bBY3wKzeHwHHbdko56HqJ7dsjmhHZqMoj?=
 =?us-ascii?Q?H+QBZENCuSc6dAGw/itmdisyKJDfEjz8Slyz9D6qXA8IZHWe3KQcdQUATAdD?=
 =?us-ascii?Q?z6enr7RQujuwGIh3tca+Q6iNW6DK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4P5kE8U61suGQc7XS2UDUTiLxEB5zmuAKd4+EMXGAK4fIGUcnu7fxN3pcQ6s?=
 =?us-ascii?Q?A17B7XeRpJshkc3ZwJWbZ8bEb4p6FEt1Iz6kPPb4+Ae4KhmTmZ5KEPvybUtK?=
 =?us-ascii?Q?TbNeVcXvAmaftN/XZQV8bptlJvt0pfy9KCq+bfab7l96gPonaQKTPGkC/j1B?=
 =?us-ascii?Q?UbzVF/H1etSghRQNoz9AfWJCppR05+ycCeq/GBFD48UGTlPO5e4bL+D9Dlet?=
 =?us-ascii?Q?mxdjkKIjs+UuH6BfZnTa8cyW3wHYu/y2Gq/89cKSQKdJdckNNXPvQv0CrLO9?=
 =?us-ascii?Q?8tAqNCAYnG2MsVeLzxg/3Ta2/cGV62cd11f1TxF0PjnSsRVtfbfK8IZjgx+B?=
 =?us-ascii?Q?tu5cJC7sj2X0MwaAvvRpFuWUPwfhaNwyDbvi7QZsKv4Q8yDZmb3tUVSyjxSQ?=
 =?us-ascii?Q?OaiFQEnAwIeA6+o+ghTOdbYQUOnIyldI/uF1YajItYDwq5fzY8Ce8DVgzX6v?=
 =?us-ascii?Q?P5hQ82CiDoQCbdxgZ21BGOUlEqY8tGqbaxxGKkaGsrEXCR+vVntsg8oBlLWG?=
 =?us-ascii?Q?VP7QMjtHvVlprg+/dXSl4JTA6XdRgBfYV2AlU2wu2ZYTS1BKy8dNgP2AQCDV?=
 =?us-ascii?Q?VoGNLwqTZkdghdMqwDu3vEguR15xzHffzmxm8j+MYtmAb4Wu5M1oapUAfgM4?=
 =?us-ascii?Q?2vyPLYnjsZJOp3GS3jjUIYrh2T0F7Td3v9bYkjPaH5kSvTUlFCnrUGf4mh4W?=
 =?us-ascii?Q?nvX25y97xksDC4P3THD+olRnDb4HSZclNFT+Lz6ehyAOQ9JzI8g08SO9SwPl?=
 =?us-ascii?Q?vhPDwhQxgvIBNrsEp5MqEfdEr4oOjc6Pv8qRmSEbtvs3i+qqLnPxxH+1dfJv?=
 =?us-ascii?Q?RMDK0hi+2JOQEikh0JMR9OKRzMrlPsIvDH6gmEG2blf6lhpr90wmzXEDzqY1?=
 =?us-ascii?Q?EWbzFpvtZC4kMEUr1klxJRESggXYh1wSxpyZE0gM9PsQc70jZDbNVH+RpRbJ?=
 =?us-ascii?Q?t7RvDRwP8o+FZDLUXF7aAE1Y9sUjPMbbRz/8pVJ7dNLclv/Q4SNXbT/LMjVD?=
 =?us-ascii?Q?vLYTy35Gy8wuNvq+oePkgHF9cRDXDRx9QMyorbuIBXSrGOdIHkVkEFKlKCLZ?=
 =?us-ascii?Q?Fuz9DQrKCligDJrEBG5Ag1gj7mNUsQCKUD/V7x0l8mZisCQtVzOd2np5sB20?=
 =?us-ascii?Q?9lD6UUZQvJImuDcXFNorkRw3yY3hOtgNKiQSvH3dYrRV9Kbk/jkajoy5O7Z9?=
 =?us-ascii?Q?ZiEedmdIuU+LJJ7gixgrJx/nz+hi1ZZm7afOskk1TtMtvqttDZgT0RQ+KyLC?=
 =?us-ascii?Q?Uwkd1qy6NzMytRMMrKueehWvu/ePMa+H/HldMeCnrHq35O2fXFeBkvGLCynf?=
 =?us-ascii?Q?FGkaGZ/MH5JNopoZohB7lIcPeAE4C3hHdeFX8DEiP1VD3rbQgquz2+w5E5R2?=
 =?us-ascii?Q?A/WBEtQOkaSZglJXxW9kCQ5byVpSxHQZGCma03N8jNuhzyZzS31HNAC9kWbD?=
 =?us-ascii?Q?yxXnwYsN0IDM1T9pl9j8GMUBwjRzmVNauKNS2BffEVDeFQ8vB7Q/XC81jnTs?=
 =?us-ascii?Q?D/7VuDmhT5YgUMNWtPEVzAh0m3ad9Cu3oIvJbspJsxCA8EglDMF83ZkJhtS5?=
 =?us-ascii?Q?u+fJrXhSurJsHocDPVEg1RFmEOY9k6JbTpkdDYQi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0172cc8f-4d34-47e6-af36-08dd5b354023
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 15:57:22.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRkIUl7p59L7g99rHAuXaPESdS0c0i/Io0nXT2WX40/AuUmBPYlN9BrhrwSj3V2Ob9almF08m/tvIisbWn50tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Mon, 24 Feb 2025 12:29:29 -0600
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Commit 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> > removed the mixed mode.
> > 
> > Remove it from the sysfs documentation.
> > 
> > Fixes: 188e9529a606 ("cxl: Remove the CXL_DECODER_MIXED mistake")
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Would be nice to put wrap back in text we aren't changing
> as creates unnecessary churn / staring at text to see if
> it is different...

100% agree that the review-ability suffers.  But keeping the text
formatted in the file makes it easier to read.  In this case that might
not be as true but I'm just kind of particular when I format paragraphs...
:-/

I hope Dave will just take it.

Thanks,
Ira

> 
> Either way
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 3f5627a1210a16aca7c18d17131a56491048a0c2..3ba551ed10e29f33b9eb873bab9b542c8afb66f0 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -321,14 +321,13 @@ KernelVersion:	v6.0
> >  Contact:	linux-cxl@vger.kernel.org
> >  Description:
> >  		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> > -		translates from a host physical address range, to a device local
> > -		address range. Device-local address ranges are further split
> > -		into a 'ram' (volatile memory) range and 'pmem' (persistent
> > -		memory) range. The 'mode' attribute emits one of 'ram', 'pmem',
> > -		'mixed', or 'none'. The 'mixed' indication is for error cases
> > -		when a decoder straddles the volatile/persistent partition
> > -		boundary, and 'none' indicates the decoder is not actively
> > -		decoding, or no DPA allocation policy has been set.
> > +		translates from a host physical address range, to a device
> 
> Ideally avoid the extra diff from wrap changes in text that isn't changing.
> 
> 
> > +		local address range. Device-local address ranges are further
> > +		split into a 'ram' (volatile memory) range and 'pmem'
> > +		(persistent memory) range. The 'mode' attribute emits one of
> 
> I think actual changes only happen here.
> 
> > +		'ram', 'pmem', or 'none'. The 'none' indicates the decoder is
> > +		not actively decoding, or no DPA allocation policy has been
> > +		set.
> >  
> >  		'mode' can be written, when the decoder is in the 'disabled'
> >  		state, with either 'ram' or 'pmem' to set the boundaries for the
> > 
> > ---
> > base-commit: 8760c1c0bf7eee63a56b5f9edb42d93737a6a378
> > change-id: 20250224-remove-mixed-sysfs-e3baa7616bcc
> > 
> > Best regards,
> 


