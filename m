Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD3291E;
	Thu,  3 Apr 2025 04:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743655384; cv=fail; b=K/SxbqY5bvOzA86C3L7vMu3R31M277GSzRH6tTdJkunDWfJ1QGIggvSJFWkffupu8t7I43WWKHR0/L5Jrk+HjJTUcK8m1xcjdcCDDt74HNrjs4oaBH43iFa4ByRDb6ZvsCLrS+r+SIf2ZXm+eeU8v0ySGjJXofYiGZtp4ceWEV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743655384; c=relaxed/simple;
	bh=+BShT8BjHEK5zTJEi/OPFwzE9yRlyIdu3Nx8tG/MkXc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GfQbAmVG5YfiQg0oKi/fg/2kaoKC/OY5tYF4muSyoOWVE87QvvcY7AAPPCXZeHrBHdrBPUQuOCL/lljIg5DS2s6xbUW2pf3cXyJF5pOqdy5Zzb1a0wHx77nLXHNcolZTtF3RvSK0xGA5Y15L3DcqpA7ekKNtmubKfeaGwfWzwUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HW2AOslL; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW2AOslL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743655383; x=1775191383;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+BShT8BjHEK5zTJEi/OPFwzE9yRlyIdu3Nx8tG/MkXc=;
  b=HW2AOslLrFdEQZE45VYM6FDUyopUzlHSJmiRJHNrx7NOZB57tRo4Xfp/
   0fcCO6BIL5bspmd7xbUqfDgPd3r1kfM5tPILR25Xc060Lgw38enBR/0jT
   4lFp8AtilNGdcoqv8wc5cNFnasWxfR+opxjX+hXCy/yX4wFM+eJw1O3Fv
   RyeCltW5kM3AzwKcwGhl4xMf/NUX0etQxP7wOHTJ8le0TyrlYJ7ZjMqBD
   tmkpgrM9yUZMP1v6jQprc7I7hFL4Zq0a//7e6UUpVFmiI47afZ1EAejIN
   i2v9yu2c0GgSpEru8SUv4Foc5PCcJ+fUilG+f4JSTACBEVPA29zQWt4PQ
   Q==;
X-CSE-ConnectionGUID: 9pu0uxY0TV+InKxfKoiPWg==
X-CSE-MsgGUID: sedXdWKsRfiWtzvZ3Tf7Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="45168649"
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="45168649"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 21:43:01 -0700
X-CSE-ConnectionGUID: ZIjmX/VMQrm107f/eJDCww==
X-CSE-MsgGUID: icYEnHWORFuZ6XB8qgGJlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,184,1739865600"; 
   d="scan'208";a="126704219"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Apr 2025 21:43:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Apr 2025 21:43:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 21:43:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 2 Apr 2025 21:43:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvRc062hhgAgeU/spVNr85xwyW0ghtHLhBK8eaT1+Pn+s7tFGFmYmsgQYoQjx0qM9fJqV6gbzPiAIbbJXOBNHjn/TMKaBh5eWdXQ0HbG7TLJjClOsQo014kFNrIIVFFPcKv0cl7iUpLq0EuarYg88q04ffkEjJ+rr9smB+z/eVxwXMlIyL2skEHGRZBeY+GbnJoUKYjfpALESJmIgV12FOwLY3GYR/NtUluYbHFeS1set6kgRktBqPmF8JxV7u9tsG1Bn36Z28WhHsFGOndEulnL9lg64JvEn96On0pJrbkGi4HZZPIXVk1t7FjS7RQk6YeWZOX7ou1Hyz5EOAugog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnSVhrJC4sOtjQyeXzsG2F5LqavD0H0KxiKn+kZBNwI=;
 b=s58BL/o9dKcC2G0zjs+cDiZi8SB2DXy0vuk1q49pNdCJuBMPuYt0aYPGbQ3V7wHN3Hm0Tv1WHbU+1HrDoY6CBIeeYit1NaN/4UzCtOhaiSWHNdghfQTtge7wCbyFWqlxgZFr3MNV0fHBvtvizJAct8m013OSACGOHll2+bh/iGCt3cdRnkr/16iWeQUeP+JAFnrDM+8uu/tKifxMdcoAoKuKJXdGuupyz1LwPKeYTLS9JVMSap0Bd8HBbqQx4+Pw2E8DxPLTtea839BpoQJn7Lf/+GdOxVcPfERutQnHOS8BK2+/XTQKtAPb8MylqE12GzLfDdhxa28p4C5f3p70YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6723.namprd11.prod.outlook.com (2603:10b6:510:1af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Thu, 3 Apr
 2025 04:42:58 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%3]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 04:42:58 +0000
Date: Wed, 2 Apr 2025 21:42:55 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, Gregory Price
	<gourry@gourry.net>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>
Subject: Re: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
Message-ID: <67ee11cf28f2e_464ec2949a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250402232552.999634-1-gourry@gourry.net>
 <2ce69e60-8a13-4e9f-b28f-1b30162a1ada@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ce69e60-8a13-4e9f-b28f-1b30162a1ada@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:303:b6::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 38dc02e0-f366-4ad5-5e28-08dd726a023a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU1jdU5PSWVKTmRZRHdpaTBLYkF1Wi9CdTM4TmtiNU5LQWpTbkpMMDJjQ0E4?=
 =?utf-8?B?djBTbitidWhCYWlVUlYxWHl6RGFOc1Y1ZGEyOXVYYzV1eERsSFpGS1VFUG1y?=
 =?utf-8?B?cDZtL3FJVGR6ZFg2ekUxcjNDK2RhNERpY2pIamtIeXFCVVVoeXRVOUljUCtR?=
 =?utf-8?B?WWUycFVSNHNuWkNHcllad3BFVnU4cXVnUThMYndBSFI3RU5QR3JZUmNUNzFI?=
 =?utf-8?B?a0xUZUtZekJxSThTU1ZRMWt3bi82SFdwQ1Bvb1gwaENJcm9XQ2FEaDUvQnFW?=
 =?utf-8?B?eTFZSk9JNjVFeWF5b0dTdmZzaUVqeUdvVmt2TEpJTGZGeGNvdU9QbVk1elp0?=
 =?utf-8?B?cTVBNEtpajAwWFNPWU02RjY1aXE3VUJqK0M5a2MvQ3dUdTU0ZllIZ1BLZVZ3?=
 =?utf-8?B?eDkxaExERDZJWE1OOWRxNUl1L1VpTnYrbVNVc2NCb2hjMnR4cHBsa0srT2E1?=
 =?utf-8?B?ck1sSnhyR1AxTm5sY3dweXVmQXVORUVIQUx0c1RFaHdZVkJqU3owUTBsQzJv?=
 =?utf-8?B?ZXh5RjFVaXl1MFFENzJiYjB0RzJYVllseDZvWFJadmVCcG01cFB2a3hWTFVu?=
 =?utf-8?B?dnB6Tm5BaGxvRVBJOHo4M1hTTXZvSDhJUUV6U01BNnNwMHNITnNPY2NRcnoz?=
 =?utf-8?B?cFA2Sk5zU1ViWnNGU1ZEOC9CcUt2UDZkMTE1UDA5Q2xoeGpNOVpCRzZVMHRK?=
 =?utf-8?B?c3ZWL1VXNkNwN3ZYSjNJSm02ckdjemN6SnArTk1YdXA2aUdSdkpjZVJ2QVFF?=
 =?utf-8?B?ZEN6MFI4Q2ZxMzNzei9qVDk5amlpQ1d3SHlOYXVndVA0cURMcXZHZTF3bXFZ?=
 =?utf-8?B?QkxOZ1NsSWVxRk5md040UDVEOXQ5dlo4dmVKOUx5UWtEYkRWd0E5Vlg5UGJj?=
 =?utf-8?B?eDlVOXJ1cTRsMU14OE11UTNiZlhWOUNJZi9UQTR3bUZtTmI5TmFRL21pZnUv?=
 =?utf-8?B?empmRG5kNnl1SDF4bTAvL3hqNTMrV3k0L3REcVlHbnl2UXd0MG5yZWtwMTVO?=
 =?utf-8?B?RXJUZ1JHcFcyb3BFUFNyWExiam0xNXFxamg4Ung3amN2bzZRMCtKT2w5VFQ5?=
 =?utf-8?B?NjRGaUxUWXprcjNzUmxkYlpCWEs1ZjJ1clRqOGVRVkpka0lNL05Mam4yRUp2?=
 =?utf-8?B?TzlFT0tlZ2xPZ3NWTTJOa2ROSW05a2ZscXpqNlV0WDRSK0ZFSTBBdUdPN1VW?=
 =?utf-8?B?N1hBMncyNG80bTA5bGIwangrT01OUFFLb0VZMndyK2VHeWtJMTV4a1lRNFl0?=
 =?utf-8?B?UHBkRGdlRm5Bc3NxU3F4VHJLSHY2UDdLRmZNeTEvVDJzdGhaVGVlNEVMVFB0?=
 =?utf-8?B?amxUSzhTZ0hCOTZHUVJuZlVNS2ZIOVlvWEtIcys5UThwdDhDL0NvdXNuMWN0?=
 =?utf-8?B?WStic1dLeTIxQ2ZJclFOd1EwNU9WdE1YQ1ZHaWVCMEpSL2dtZEdPbnBFNmhw?=
 =?utf-8?B?aDlVMDRJM1B3cUtEN1lxQUdwRW9nNGd6V2NWTEpWT1hSZk11aWQyNE9pY1Jj?=
 =?utf-8?B?SnFTcXBjUmUwY2VncmxkZ1ZCL0M1OGpnU28vazM1Ny9mNVhHdnJsdTRDYXZy?=
 =?utf-8?B?Q2NCcU1ESWZkRmsrWFBHTmJkN2RNUlJOdUFlR0R3SWJZNnBNNmEvSCtCR2Vl?=
 =?utf-8?B?NEVvTTVuYnN6T2ZpY29sWE1HQitxL2R6aXdiN1ovL2lDR3ZxS0RRWitXSnh4?=
 =?utf-8?B?ejgzell1S3FEQmd6Zlh3Ylp3dXJiT0ZjR0MxNnZodDJid0c2V0VDYk1PbDRE?=
 =?utf-8?B?ejU3dmZEanBVYVp1L3cyVVFlMlJMVEk1WjFnbkFiWVU1eTNHUEl0cVRWamk0?=
 =?utf-8?B?WVplT0pyelJ3WTlhNVRDQU1GdUlqcVd1bEdQR09hcmdJRTdja3Y2TjB2YTA2?=
 =?utf-8?Q?CzlFUKzx/khUM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW4vaUtrSVpkRDkyenVyakc0bWxJSkR4eXpralE5S2ppNTl2M0xmVklrVFpS?=
 =?utf-8?B?NENtd3FMTTkxZkJFbWorK0hzY0huY3JYZUYyT20rOGJVZndaRWdqdzdwQVJq?=
 =?utf-8?B?Nnh3dE42RldSMm8yaWZ1dkJZK1E3Rko5SkwwaStEOGs5c3BXUzR2amJ5ZXRY?=
 =?utf-8?B?S3BYSFRpOTB1eXFLMHk3akdjNFNYT1FtS3FGNnZ6c0Uzc0xWQ3ZIU1BweVFN?=
 =?utf-8?B?TDJZWVRDK1hYMzVWNWFhbWxsM1pBK2lqWUZxNXczWWR4OU9qOHExTmFaTUpi?=
 =?utf-8?B?SUkxbjR2SWgyZGRwbnhNRjY0a2RaTjdNNXRLd0Z2aFBOcStLNnV5UnJ5YTI1?=
 =?utf-8?B?c2NDcHQyckhwUm5DMm5jaUdQVy9YckZ3Mmthc21ubWVzQlB1Tk9yQWk2Y1k5?=
 =?utf-8?B?OWJ0SGxkSTdocG02SXhuY015dXpCbHZiaWFUeEdMa3VwNWk4dHlBZm9UR2Vh?=
 =?utf-8?B?TEhrVTVhRktDd3VuS3lOdG5zY0FPMHlDTDFieGVIb213ZkM0VFAvcnorcEI2?=
 =?utf-8?B?ell5U1JkUVlBQWpoSDcxUnBKaHB0eS80WDRrNC9mUXZTaXM4d1hqMHJiRkR3?=
 =?utf-8?B?MzZJZDdNOCsxQkV5YjVwZGg5U2hFRWs5R1lpeExnT3MyZzdlaEhIclFvQUhx?=
 =?utf-8?B?Ym1oc2VMUnN3b1lFWVhubkVvSUxzVmZMamNBV29ZYjRpT0laUXU0aFBacVZP?=
 =?utf-8?B?dDRoLzJodEFNVzJVODAwQ3BYaWRadFJuM1F6MUQxV2xGZW11cm5kdU1FeTNn?=
 =?utf-8?B?bzFOYjliT05zcm02V2UxUC8xVXl3RVhHNDQwOXlENnd1T1NvTUZOaEVwN05k?=
 =?utf-8?B?TlB1T1IwcEhjMFViSTVVR0NjZEU5dDk0QmdJRGpEaTJubFlwUzdaZHBNa2Fz?=
 =?utf-8?B?eExvRkswVHZ3Z1RMSHhxaDc4UUUzUm96RXBnK0dqeHJJVjRKOVlpckVVYXhG?=
 =?utf-8?B?NXcvb3B4YmtWdXJUS0l0dDlxVEkzOERwQ09qRTlKQWFNaTg3bm8vNVlkbDNU?=
 =?utf-8?B?Q2pZTEtiZ0tYVlFuM2hsSFZJZ21UTHUxV0pXU2RLL1llYnpvYllvWjhHdjRo?=
 =?utf-8?B?akxQOWlyTFk4ak91RDU1MUkyckhsUjZFa3RqS1lZZFc5REdxaVhLUVhwNzZB?=
 =?utf-8?B?eStLeFN5dm9QMFlnUlRYWW9nOTlSUm9lMGpVMEJ0SFF1NEw1K1hHSURMQ05L?=
 =?utf-8?B?ZDV6anN0bnpNT213VE40ZXczNmF5ZkFFN0o2TlpPV2dUWHVVLzdlVDlISXBH?=
 =?utf-8?B?MWFueUpwUTdEbWdMb0tmM3N2empDd1dxSUJxOWFheFl1MHZyd3BWVGRFbWJl?=
 =?utf-8?B?ay9EOEk3Y29xMHNQb2V2N0JUYUZRS3ZtRkR3dURBTVkzajZWTmdHb1RqOHFF?=
 =?utf-8?B?MlBvUmZKSUp3NlRWc3FySlphV1lsL0YrYlNLcU51T2tEWnFqblRLOUdMWlJY?=
 =?utf-8?B?cEZrcDBoZ244Q2djNTJHWmUrTDZmaGFWOGNuYTZKeTFkL2lNSVJkZ1o2Rmow?=
 =?utf-8?B?cjBVMGFYZ1Jja1RwdFVQZmpSNUxnSUpCZWNnNDhIWFo0bk02TFN2YUJCcUxB?=
 =?utf-8?B?dGxyWnREaW5ka0V0bWI4Z2VlOUNvcFFXTHUyL1RVbWhvamtYMDZGcHhqZTU3?=
 =?utf-8?B?TXNTdCtWUG4xeEkrcm54ZURRSUc2UE0vT1pDZXAxcU9FbXZpZ0FqdTZxZ2JU?=
 =?utf-8?B?OSsvMkJJL3VPVVFNU3g5d1RaQUMyK0FTZWVtbmp2c3Q1Y2xrZy9CN1JQSVhV?=
 =?utf-8?B?QjF0a3ZxcjZsbGN3VkpTOXpYUnhqVmpuOWxuWENjbG1FczVFSnNpRlRGVDZ0?=
 =?utf-8?B?WTN6NDNNeHVvajN1U05zUDVOY3VTNS8yVDRaQ0ZoQkVpdWdRam12Qm55QjNz?=
 =?utf-8?B?RzV4azFiWnh2MnA0V3BMSlF1Q2tqeTdTcWxqNXJiSnJXOTFsamQ1SVJuZTkz?=
 =?utf-8?B?aytNODl0MmxhOXBSdTRJNUZUdy94L1hJdHBZeEdpRVVBdTBMZ2lneVo2RXRi?=
 =?utf-8?B?TXlYN2NkOTduTDFqL0N4SytnWXV4azliVGlndTZkOEUzdm04K1pYRUx4RFFo?=
 =?utf-8?B?OTZDSEdBM20vYlJNM2JQeGdUbzlRai9tZmx5WGFYWXViT1JEM0NHUUtxUTRs?=
 =?utf-8?B?NzU4VkRRVzcxeVVOZVVKbW4vczg0YWVFN3BDS0VRMFV6Z3ByVmRPMnRIcEt1?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dc02e0-f366-4ad5-5e28-08dd726a023a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 04:42:58.7272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRQyuNDfn3jLSrgxqwa8kA10V5qJQUTSvQyOk1X1BaCcjHjjl6ffaknHA/ht/T3JdQsdnGRD9OTeLwFUmO94VxEc3wgu7yGBnClNNMHNeMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6723
X-OriginatorOrg: intel.com

Zhijian Li (Fujitsu) wrote:
> Hi Gregory and CXL community
> Cc Goto-san
> 
> Wow, our platform has encountered a similar issue, and I am intending to consult
> the community regarding this matter.
> 
> I drafted similar patch locally, but I wonder if we should "ignore" the IG
> or "program" the IG to the decoder.
> 
> Let me post the mail(question) from my drafts in your thread(I hope you I hope you won't mind).
> ======================================
> [Question] granularity is a don't care if not interleaving?
> I saw this sentence " granularity is a don't care if not interleaving" in this
> patch "[ndctl PATCH 2/6] cxl/list: Add interleave parameters to decoder listings" [1]
> 
> This reminds me that our platform programed an unmatched interleave_granularity in HDM decoders
> between endpoint and the host-bridge, see below:
> 
>                                CXL  Root
>              CFMW0           /           \      CFMW1
>             decoder0.0                        decoder0.1
>        128 GiB       IW:1  IG:256           IW:1  IG:256      128 GiB
>                               \           /
>                                Host Bridge
>                               /           \
>                      decoder5.0           decoder5.1
>                   IW:1  IG:256            IW:1  IG:256
> 	      /                                  \
>           Endpoint9                           Endpoint10
>                |                                   |
>           decoder9.0                           decoder10.0
>          IW:1 IG:1024                          IW:1 IG:1024

Why 1024? Yes, the value does not matter, but attempting 1024 feels more
like a unit test than a production use case.

> 
> With this setup, the Linux kernel attempts to create regions for Endpoint9 and Endpoint10
> but fails because the endpoint decoders’ interleave granularity (IG=1024) does not
> match their parent decoders’ IG (256). Ideally, the endpoint decoders are expected to be
> configured for IG=256.
> 
> Currently, we learned that we have only special handling for the root decoders [2][3].
> 
> My question are:
> Q1: whether "granularity is a don't care if not interleaving" is applied to
> all HDM decoders(including root decoder and HDM decoder)

All decoders.

> In current cxl cli , it will not show any interleave_granularity at all when ways==1(no-interleaving)
> $ cxl list -PDE | grep granularity  # show nothing when ways==1

Right, because the value theoretically has no functional impact in the
ways==1 case. However, it errantly ends up having practical impact in
these corners cases where code performs granularity comparisons without
considering that ways may be 1.

> Per the CXL Spec r3.1
> IG: "The number of consecutive bytes that are assigned to each target in the Target List."
> Q2: Does this imply a configuration where the number of ways>1?

Right, the granularity is the boundary at which the decoder switches to
the next target in the target list. When ways=1 granularity can be
infinity or zero by that definition.

> Q3: Does the IG also represent the device's capabilities? When programming, should one also
> consider whether the device supports it?

Yes, see bits [9:8] in the CXL HDM Decoder Capability Register (CXL 3.2
8.2.4.20.1). So even though the math should not matter, I would still
expect the driver to try to be careful to make sure that IG+8 is less
than the address-bit max.

> If "granularity is a don't care if not interleaving" is true, how about below changes

Part of me says, "yes, that should be ok", another part of me says "what
is the practical benefit of allowing any granularity to be specified?".

So the fix from Gregory is limited to the case of "whoops, the platform
BIOS thought this was a good idea even though it does not matter in
practice, teach Linux to be lenient in this case.".

The proposal to accept that in all case allows user-created regions to
have odd large granularity sizes in the iw=1 case, and I am skeptical
it is worth supporting that now.
