Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7F513D24D
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145424; cv=fail; b=Z2SaGsoCsGbPNsAdd/bsB9xqs8ElskDYn9vF+TD8PBcw1nF1hlVhLH59nvUE2+UcRGZTHnaw65pPUzxq8mzXoOfpIJNEIWvXW799kaOxPNzlb/UTK6fWLoH/aG4RbvM1hJ5Q37lYOOQ7hVmZFjrhgCudL8pg6ZZVoTEj2MOGhiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145424; c=relaxed/simple;
	bh=CRm8K7DBuQPld2+TMnHpBOmRaH1+XYe5VLPZoKY0/jY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j0L1Me8RoH3YAuqYUT0NzbfHEjbNW40g02GiiYsTfaxXTCNAA4TpCmcp19Dmx5wxiKWLAXdqEw2SYjDjACCdbSZD/p7nvbWZP2a7XWisHBaXV1ZUfalctWgtHQzqhAsAuHIyZ9jVL1vFRDBMF5+AkKJ1ULlOPLkuh7AbDHvdUAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHAVy19E; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHAVy19E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753145423; x=1784681423;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CRm8K7DBuQPld2+TMnHpBOmRaH1+XYe5VLPZoKY0/jY=;
  b=JHAVy19EFiNooCQxTvZW595w8cU/+XgrhNRNxWXGAuxrIJ/IN4MD7zix
   jt3y+vLwMRa5uAANFso0ZcGrGhX5RCWyH8EWOxQCpRmDr/f0aj0vQkh7X
   dB/ZCKFAIgrkR2+weYJ3WvQOPUG471eI/cgNLFhtx/qkji1DUjIO4qWOZ
   CGZ8BTRdLaob2SZKcArv+EDdovjDFcQgnT28kBIDzVBm3pdkYKkhLBUPr
   t5us/PuMJtkbaGcxXRT/6faGRWsX9evIXY/LunohUEQVj7gBJMMSjWBFA
   ZCJCPFygqHzcVhDBqCeec1n+j6+VnJgut4+6YqXd8lRtS9iTZC6mSGtkF
   Q==;
X-CSE-ConnectionGUID: 4pS9Nc84SzyNKmmkbBotvA==
X-CSE-MsgGUID: 7/A38c3DShuCt2kOIspQew==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="66811849"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="66811849"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 17:50:21 -0700
X-CSE-ConnectionGUID: hBBicwkEQ4mkFUYo2aoS1g==
X-CSE-MsgGUID: S9DXxmujT8KotwyxMfQYRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159032897"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 17:50:20 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 17:50:19 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 21 Jul 2025 17:50:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.59)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 21 Jul 2025 17:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSJrV9JnVKIgqAJ+LOnPHs3uNJe9MekEfVPa6B7+1a623JmuOzVTHoElg2I2LtMpXX9tcA7vk/QJZiUfM3hMXmgYla0hejn/mGDJ4dgbNDRM+UMzhy3ZKZf0lCqCoHAwkQUgAkzb8wmykpu9JTCq14sgf290vZY8gl/vpFF3cEbBFUTFG95jvHDqUgsgXKO5DTUGBYa/RRhZ7qo02nfw6lF8pW0lMAW3oymwwpsuJDPQBw3Wm59G/R5GnoG/wrYIMl/I83MWX5o+UujShT2JURCW7IM2uY/UsC98fsO80uQ6+K/WePACShOKOiu7zS9dcW+MVzxXOblMmP5lTSOUqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSuD/vcRczSRUlYnl0i1jTCoq0k6xPnhN6lEEj366KA=;
 b=Qlxd/9JyQm3VTUUV/D4BGmSxHanGP6sUaBkD0HeoFiVjG/fTN6YNStO0GXvP5szHCQm8qageXfbOS/6xSHYPdEhXLPxEWKhjZIp+Ja8lQyvzfjmA0JxnS0CYVv0GmPPhxo8ruTYUgBZYjxPHX2k07KQnZOfBLGbJEXecpWT4/35EAwgerpeEqxk2KD7EGhKF1XdXn4jzNwn31/ymZoCo5z8m8HzNyzl/QFiSKYMlXhp4D652KqaCWbgwDTtfYys3vMLhnVohjIzQUVtExKbg/p8lAFQdsI2Mao7WZJN+w8w7niRGZhFeAmzUomkVzwuIyzOoqSMt/+2Y8W+y6cJGBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Tue, 22 Jul
 2025 00:50:03 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4e89:bb6b:bb46:4808%7]) with mapi id 15.20.8922.037; Tue, 22 Jul 2025
 00:50:03 +0000
Date: Mon, 21 Jul 2025 17:49:57 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] cxl/region: Introduce SPA to DPA address
 translation
Message-ID: <aH7gNXH5dsGr50wP@aschofie-mobl2.lan>
References: <cover.1752365427.git.alison.schofield@intel.com>
 <28eeffc8905e658dc3ed62a7c52e030cbcfd5158.1752365427.git.alison.schofield@intel.com>
 <20250716115226.000067fc@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250716115226.000067fc@huawei.com>
X-ClientProxiedBy: MN2PR20CA0052.namprd20.prod.outlook.com
 (2603:10b6:208:235::21) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA1PR11MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c9ccc6-027a-4b7e-6454-08ddc8b9b1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TAyIzZXRPs1FiHkNFvBiv+RJQCY4UxV4yQOsh4LGtDe9SUjsd9tfsZGY5lEL?=
 =?us-ascii?Q?5809tunDkbreKt/wf1jVhiOnkTffpwQkCul/MipejtBOigpQYI9KoHsN/GLh?=
 =?us-ascii?Q?EDrUr5KqWao7kTN2Q/OTOrTl2ioa/SGNgEVySWsRBSh/UCJ7bXRfc0Nq7zEZ?=
 =?us-ascii?Q?H5Yv3oX3mFKhIcpxJlT3JXyogWvsD3LY5w3Mc9RjBcyTqomOGG8KvDgwTH9E?=
 =?us-ascii?Q?9cOkgRpmg1gkFPDtxZPcNQ3juOC+MFeViA4UXWUhtczB7AKpbWOE5sMYCgT1?=
 =?us-ascii?Q?wUsRnMRfy+R5ayYIpYE+srH1z48oKSgySK4HVMeNUpKR+emwt9Iys17tsRt4?=
 =?us-ascii?Q?U1eY7Tu9EEZwjONyoaU7dD2OsWd4XhU5DjZHo7SM+cfKEK3W7HTBjLVAHOfb?=
 =?us-ascii?Q?t1Q21M/6tYa6jn9EZcdojghaXbe0L3ZCgotv2eYOVo968rwctPcBWmFiU9dx?=
 =?us-ascii?Q?tb44D38n2pL+E3t/9ZXcVi3SDaVqFPmJ6LatKMzJMvVacyIHNWoOzGC2j/pI?=
 =?us-ascii?Q?FOumdcx9AjCxLezyCY2XGrGwqov90teZthc1BpVyWalTdRtzgxWqatW5tSvL?=
 =?us-ascii?Q?qarlFDM6vPNJpdprUupxiY+RIixdmwsqmCH8oQWb/Kux+WAGw3Na8Jh7KndP?=
 =?us-ascii?Q?v1gZ788p8hmE8c99P9bVWbYhciquFY96Ag3s01h9pL9R1jkLBM0IbuFT2Wxy?=
 =?us-ascii?Q?rJaRSMCThPV5FeVDwoPWvPHZUH3kal7olvgOtVER+lvTww49zqblLbxYFTGe?=
 =?us-ascii?Q?lRmtxfbgU8hSJ6nexVHIpgwOlJEjrF4EUFZgZYyMyZILdGC9Zegwqbu/xPDX?=
 =?us-ascii?Q?l0aakhXFs/nUh8zVPitvZHnI6lglZ2eacYva7/99BbZXuO7VGuRw8GvQKnpI?=
 =?us-ascii?Q?K5uyoAD8pA1IJnXRLFNhmLtJVdLfUXIxbTyS46g33JeEEnupIlN15kPLUWda?=
 =?us-ascii?Q?VlDh4jq9wmW8inNyJLdQScLfJ8KBWT0MrImnbJ6ZhsAb8B2jcJajsDii2ly1?=
 =?us-ascii?Q?HwnKPhMzFyiijJomCV3s7bni2bHNSgx/3PA8cj74HZ7iOxLYhorI8SKKGXXN?=
 =?us-ascii?Q?E4HGGZFCNM487ogK3vScrkB3JIizR+8jSmUMIV3y90KUGmMxneoEjvlmOnss?=
 =?us-ascii?Q?nrK7tvKn2T3bZDq5fMEWhL7PQ6QVtBIZjPbS7CaChVOLto8oOPsmFfyxyMCP?=
 =?us-ascii?Q?s/pabIumuV3dHjekhVm2Nwp0oICmgjtdRAFs5RYu5QX77g3lwaTBaf8AeoEk?=
 =?us-ascii?Q?O75zPv1NY4FYm21izDBmqBELHeuSHu9JGhPj5tAkTCAD7Ib3Ozw4DqmDEJZF?=
 =?us-ascii?Q?slBZoQLChMSlz0FfIDFqNoVSvXAg8hz5CZpx/AKWVCfLcdFU9+qspCLZQzYl?=
 =?us-ascii?Q?R86uhjzWwA09W7CnDD8YpdiADbj5LZ2ax3yY4e6Mm1LBTEu1NG70SWAjNgnm?=
 =?us-ascii?Q?8pkUghwD9as=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k33yr8Oq587i6+Z3T+X+xia9VAIVZT7NYEab9HT0cMDsUAlN9v1Vh41Mha42?=
 =?us-ascii?Q?L19z2bZOLO87CaCA6eQb39jTbf7I+pabL786EXs6PnjxTlv8CtIqtAkLHnmF?=
 =?us-ascii?Q?3KCrvcXmjxs6wSQzGOc/WzppffawDP8gSpXWBotSIG0V63gxVHFMLMipn4Sx?=
 =?us-ascii?Q?aNLIoifoAiadATs/0pLemsiX/6oOckKKVl445ZW5FlXMfarw5KhTyljAMaEX?=
 =?us-ascii?Q?9HS3HPYH8LTtfBCcklqrdovCpMkrVKWEi5gQI38NnfrC3sgY5Pydg644M4Wt?=
 =?us-ascii?Q?h2fouoXVOPN0UJU1vAKSqHLBcw/wkEZ6+XNykYTZC2OGN9fExDtxTuLcQISn?=
 =?us-ascii?Q?/Y75BP2QIgGOziN2XsCbrya9cYkhD0Vgmdh8ojvh9DwKRX97MW5AtxZGRXaj?=
 =?us-ascii?Q?ht3O2roEhGwFz+Ce2/vA8DRSlCfXR1aa8946bJnrgzgI7zcUjgbYxxwLIs8l?=
 =?us-ascii?Q?BO0ciuSrO7bS9sRs0fVGBUGCIF7LiU/IpNF87lkgWQGKnGB9RPk4WdvS0te9?=
 =?us-ascii?Q?q0RY/4SW2JN5FN5x4G4+RdvIn9tpujEs+GZwzGc6C/rQjEor/a0rElYxvk8V?=
 =?us-ascii?Q?2eY0B7BcxkuZm1PJWjnTYLfsvlhZyNv23BozuUCY9qTalJczJuaFsoVNg4EP?=
 =?us-ascii?Q?tIIv8FNi179/8pPOjKocnztW9QpN1SWKPGik8r+6IgPnMkdx4A0S9VBxtCRF?=
 =?us-ascii?Q?6+1ASiiX8ZPkMxnXTLh967aeGU+dw6YvRKPfU0y/Z45fizgxDhh5EGYQDKOl?=
 =?us-ascii?Q?KySRP8/Xcfv1AaLcrEVnnedMELS7gVWLEmnVfTjFa5H2uBGPsnSZNESTCmWI?=
 =?us-ascii?Q?KQsr3FeNXLY9u1xUH0zBcnbpOOLYGjz2WIkl2VYv6Xx9WHtOYgR647DJouLJ?=
 =?us-ascii?Q?aFJ7uE+1Ul3eCKVW0DEPrkwWoDmsSewPVfZb3/xNUSYev8a7jQqzcpVOzh5z?=
 =?us-ascii?Q?ntnaFXpCRj7P5x6aXi782mlfqKnSYdSplClddZbBzuwpzdOQU6kCCWQTAi7U?=
 =?us-ascii?Q?fmh10Qg5/Efuv1gZ5pBm1P6UD3ndk4SQefoEgGzvZyIpcFWN1x51RwHQzE1B?=
 =?us-ascii?Q?LpmAQs1ZyhnWlaPwVOvx6Xq0O0ofq4bjLQJYuW9b917brh4Hkt8Gtyo0Zr8v?=
 =?us-ascii?Q?WDxS8VhpZ6/J5ONYEdhuUNTU3Suvg1NiT0clQR65GR1Lo7GaRSAAq6Vw65wa?=
 =?us-ascii?Q?VMSqy4mHtPsOt7Mrn5nt3xh5bjJ8Jix9nakmGJI3/HcETiXbdPfFox+t54cD?=
 =?us-ascii?Q?AxkCHUhqV/b/ZczexA5TIvZGxuCrLdWCoq6cI4vCcCD2eTiQnlXgEcBxzh7k?=
 =?us-ascii?Q?H0qPes0xPywxIm1t4GUT6N6aiKuqjLqVpNaC+xzkSRMrymc27Uq15fkIf01p?=
 =?us-ascii?Q?XqLHraWHdHtvKv1cIpXMiFMX3/kA6sPxGH5567hWtax2Q58ydlOO2pc/9JjG?=
 =?us-ascii?Q?wrl0ClWqe5zXAaki+sjwAoYoKp5Pl3XHGl4vz3mX2hO2Z21hpent1ZNWc7FZ?=
 =?us-ascii?Q?fxUNOw6G3+wqbjZcu2Js712HYk5jX5Da652zkoQamNGxyTPNTmYv8IbujLDr?=
 =?us-ascii?Q?7tKa0GqFi6lW7/romnDa3mHhMhWGEMZyqdWHk/OusVRhuKh3g5FvzqGm+lqk?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c9ccc6-027a-4b7e-6454-08ddc8b9b1ba
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 00:50:03.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmviXd3B8Y66nn496Oru80HoPM1WbI+/KpmgJyFmZo1ZqRg57PiJBLnKaJ32fEPOXcPoocoa4NIqbdF/8o0W88MxZoLFvJ5sv+MZ3IzFrqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-OriginatorOrg: intel.com

On Wed, Jul 16, 2025 at 11:52:26AM +0100, Jonathan Cameron wrote:
> On Sat, 12 Jul 2025 19:37:55 -0700
> alison.schofield@intel.com wrote:
> 
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Add infrastructure to translate System Physical Addresses (SPA) to
> > Device Physical Addresses (DPA) within CXL regions. This capability
> > will be used by follow-on patches that add poison inject and clear
> > operations at the region level.
> > 
> > The SPA-to-DPA translation process follows these steps:
> > 1. Apply root decoder transformations (SPA to HPA) if configured.
> > 2. Extract the position in region interleave from the HPA offset.
> > 3. Extract the DPA offset from the HPA offset.
> > 4. Use position to find endpoint decoder.
> > 5. Use endpoint decoder to find memdev and calculate DPA from offset.
> > 6. Return the result - a memdev and a DPA.
> > 
> > It is Step 1 above that makes this a driver level operation and not
> > work we can push to user space. Rather than exporting the XOR maps for
> > root decoders configured with XOR interleave, the driver performs this
> > complex calculation for the user.
> > 
> > Steps 2 and 3 follow the CXL Spec 3.2 Section 8.2.4.20.13
> > Implementation Note: Device Decode Logic.
> > 
> > These calculations mirror much of the logic introduced earlier in DPA
> > to SPA translation, see cxl_dpa_to_hpa(), where the driver needed to
> > reverse the spec defined 'Deivce Decode Logic'.
> 
> Device
Done

> 
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Hi Alison,
> 
> A few minor things inline. 

A few responses that I've addressed in v4 -

> > +
> > +	if (pos < 0 || pos >= p->nr_targets) {
> > +		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",
> > +			pos, p->nr_targets);
> > +		return -ENXIO;
> > +	}
> Maybe a blank line here.

Done


> > +	/*
> > +	 * DPA offset: CXL Spec 3.2 Section 8.2.4.20.13
> > +	 * Lower bits [IG+7:0] pass through unchanged
> > +	 * (eiw < 8)
> > +	 *	Per spec: DPAOffset[51:IG+8] = (HPAOffset[51:IG+IW+8] >> IW)
> > +	 *	Clear the position bits to isolate upper section, then
> > +	 *	reverse the left shift by eiw that occurred during DPA->HPA
> > +	 * (eiw >= 8)
> > +	 *	Per spec: DPAOffset[51:IG+8] = HPAOffset[51:IG+IW] / 3
> > +	 *	Extract upper bits from the correct bit range and divide by 3
> > +	 *	to recover the original DPA upper bits
> > +	 */
> > +
> 
> and not one here to keep this grouped slightly more closely with the
> code it is talking about.
> 
> > +	bits_lower = hpa_offset & GENMASK_ULL(eig + 7, 0);
> > +	if (eiw < 8) {
> > +		hpa_offset &= ~((u64)GENMASK(eiw + eig + 8 - 1, 0));
> 
> Really trivial but I'd use eig + eiw + 8 - 1 to align with the parameter
> order in the comment.  With matching that comment in mind why not,
> 
> 		dpa_offset = (hpa_offset & (GENMASK_ULL(51, eig + eiw + 8) >> eiw;
> (Go long on this line for readability)  Or use 63 if you prefer for the upper
> a should remain safe.
> 
> Not using hpa_offset for the intermediate value avoid ambiguity about what
> the value is at that stage (it's not the hpa_offset
> 
I've flipped to eig + eiw.

I see the ambiguity introduced by modifying hpa_offset in place.
However, I don't think doing the work in one line is needed. The work
flows like the comment:

* Clear the position bits to isolate upper section
temp = hpa_offset &= ~((u64)GENMASK(eig + eiw + 8 - 1, 0));

* the reverse the left shift by eiw that occurred during DPA->HPA
dpa_offset = temp >> eiw;

See what you think in next rev.

> 
