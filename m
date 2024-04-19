Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2119.outbound.protection.outlook.com [40.107.101.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C5113BAFF
	for <linux-cxl@vger.kernel.org>; Fri, 19 Apr 2024 18:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550348; cv=fail; b=QMUOWq2knBn1EuLNVIdYt9N/gYgRJW1eUZIBp9Kle/j+u8cQEFlAeV4l8/4Tj94pqAj/eWF25l42iVcUWofB4pa/A6FFGPs2OQzxPh7fuofvzZxp/2HURNe0wRtqGECNC64/8BGOG1gVHHkJxv+USzw4zNr0ar8HIteUSWhrlFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550348; c=relaxed/simple;
	bh=1/JL1/H+HDaDVrdi67BqkupJkNh3LgIQzzWCph42Xhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d3BYD7Jgk2iBgNvbkryrXaArghqDPN/yQH9bR99vkbjCeQE9dfvjs/zER++9HDbXTrViVvNlRXLxDb6iz4azklViBgTkzdkCzcMvIZqOD9FUxSoLT3QZmHMJ1/C2LKq2w/e3Vncnpl7IMTn3QAmzX+OgUYQcqnU3gxsLAd8NcoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=oAiGEsua; arc=fail smtp.client-ip=40.107.101.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="oAiGEsua"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APJRp6V1YIp/LHsLQFwRzws5IuI+Z8+QR/r867bEfIqa9D0iOgnQylkUQeN6Ypk5P1eeCqMxXFOVdARpsCCXVaOmlcy/Af+HHrtXPHl5ixrpjTeHztm+u/VFFdc5jtQqzJOe0MKpd1Im09op62ekF/UQwD63DN/3CgBzWU8RGZVRO4WBFS4rMbkwm7mD1DMVdKx7qdXDTOabjxL2hHCBXbuvQiwwAMvhW3LlGfxCsVspiMRXt9m3Yzkw4lP4EPhJp73zEgc1o5v1sE5l/tjA+3YZ8TsBOQ0bKgv9vtdCzZ1YjCk9imN3EzeNnbpiEMD5VN9D4K1L0TZjqTNtQzWelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QSUq8fEngG2ytREEJvBapmEPDGy6fjOpqznaiQhMGI=;
 b=QoMlTG54s0a0bdmiO3b0zq4AH2UtaraPVGp7TnHAqNHXIzbSetvpya11xZLWg4yu5eSUAW1wBFop6LHRN++iW+f1CJYrlbLkAGQSF0u2nYBc3KHwxjgkmBn/ynPEugqNWA6cywFOF/lK4tAnQLSL9TbDb8bkzQ+RrHKkauZX+xlLlGLgV4oUfSm2L7arbTSDJvsNpoVlwUi9306EmCOjz/foUnKz/x1tHEm2ytDU0Vf+HSmvZE4SMRqYLbdLPXLLvrPT9BBnydC2ATAvpwKWV1S5DlgaWLwQ6nNsWrM0E2IrC+M0916BBGSizabi7lp3IG4wTuBnQQtE7/yh6nrl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QSUq8fEngG2ytREEJvBapmEPDGy6fjOpqznaiQhMGI=;
 b=oAiGEsuau/maWBEXEuiVDOaQcBYctqq6dI/+FKfhwgTESjfoaZ4kjslz7F+nVIIKcUXRhCCh4e7tomgIhbuQmn5zUpb7U1sq5bRHkuARvitXh8upJS82QVEQ2+HZTastoEv+xmGXatn6wkoSafuoneCN9bSSgpXh2Z/AqD6RLJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB4691.namprd17.prod.outlook.com (2603:10b6:806:19a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:12:24 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:12:24 +0000
Date: Fri, 19 Apr 2024 14:12:16 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 08/12] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Message-ID: <ZiK0ADOsUMtX1GAK@memverge.com>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-9-fan.ni@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418232902.583744-9-fan.ni@samsung.com>
X-ClientProxiedBy: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d831e21-6f95-4805-3ea4-08dc609c4363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/wDY+WMDAcC057qJ3nbFaKVMn/UgnsEecqnjBlot0QtV6T2R5hBfZzx3CySs?=
 =?us-ascii?Q?ay6DJncYXPyTHXbIfexhDRl/bXYZhQ0fNiuUtPBBOIFDDxix8mbAoAOLK/3J?=
 =?us-ascii?Q?R4+sjRx50m3+a/kpmdifm1dha3BIl2L9WnFxZKc5cL3JczUtrz0CFtEJro32?=
 =?us-ascii?Q?1c3xv7cMPkO5YsrjJsX57RkJSrphJac1/n59fVoEkD0OPsMhbI0ruGSb3tnG?=
 =?us-ascii?Q?j05SZPXSDPY7/zi+Ngpn0NIJupTgF8hmqFMpCqZaSbNPMnQJ8PNf0H0pNpLf?=
 =?us-ascii?Q?Wr/+otHRR813FTfWORYU53Igr16DLpQ5rdOfKU2upH+20nD4eRMtZwoZq7iE?=
 =?us-ascii?Q?SYHt/rB9fpST2vZhtfFHvkgSffKinN58PzhKwTLZtx0E2fOgG1C0XVIErQY0?=
 =?us-ascii?Q?N2AK7Vl7goZHAZphZZ/EyGK0CWkPDiYeH5caeFhU3QgP+ftlMEc3dfANMjun?=
 =?us-ascii?Q?Xsd5CcGKof5BCXV3RWJsotkGB/wiwVDUhcqRXGkcb894uvziU7oyh56uSnhS?=
 =?us-ascii?Q?E0H5bd7ZRufxC76hxR0ytPL5vzemqlA/iRovJoYOsyBdbhD4RQjGpYonLL7a?=
 =?us-ascii?Q?0YLmrG3r8u7fj39PvtDpuchCWX1KsL3Eiz2zCcUzH9FLuPZYcbEaluCf6ZEA?=
 =?us-ascii?Q?NIGFYPw3jkPIy6LZRpSGGDg5CD6NZ/fcw4rK+UgKyLXrDmN2fvbZgCmkIhva?=
 =?us-ascii?Q?QBoM8jIWzJpOah/F1XgSO1RrAsBal03oexFpGM85ehmHBR1OMfo1KupQC2x2?=
 =?us-ascii?Q?t8sdQlMgMvhos1punCbVYzAzskAHAm3krrgz6oRLtRHQ/ON8rztCXyzCFyto?=
 =?us-ascii?Q?guYweQl+ZgjuM3J7r/Dq5zdKF3dsh3sfX6g92j2VWX0W9x62StmyjnmWZ3yp?=
 =?us-ascii?Q?oUWQV7zdsgYAoGJX3Qmj63R/GVXKME9nl/gOGwqZlENxMef94Aiw26pR6d3Q?=
 =?us-ascii?Q?+C4CSuIgIPX8lfALtK64oJ+WrF5zu5YeJeyxBuM2ArzaqIbae+qcM7CAvXBC?=
 =?us-ascii?Q?ZCL+LXbtEMwQzo/EJC4xQRDwjWQgFS1hsKZQ88fj9BFhlsuvQDjN6og4ZgAL?=
 =?us-ascii?Q?331H8R+bO7qyQmw/qUfEEj/VXloqODW+m7RBgzDIBTWL6VfahUgqZrg8zN6e?=
 =?us-ascii?Q?3Gs/lyUorvyNSjXMW7blz3PxdNtd9BqhhOAAfXAoH80lKmvutB7DS6xMkKHl?=
 =?us-ascii?Q?0zJ2YUVKue/srpe7FQs/20v26sOcehLdYKxwZmpbKqr0LmA80R7wQYHEg5Zl?=
 =?us-ascii?Q?FT3ALP2QoO0PjQVmWj9eauVu2ly2O36OHW54iYNGsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gO3ZxG/zqfQRdidJw8JAQwOsahW5DHQ46inE1f5C+L84ljXTXMpF0w4BMYN8?=
 =?us-ascii?Q?8Z/3hMe847Zxzn1kPeK3oOpWhquTuH4WvnpH3GRUk9kJ5fJqD4UXFUxUlizp?=
 =?us-ascii?Q?a7w+36tIJNQnVWS0a/cYSIMS6AQ7yeLVIXFkBxOXqM9+03Sb0wT31F3ZQyjR?=
 =?us-ascii?Q?STKZAJ/Mr27mABztj7NRbeCmZVZ/1dicNkRONrD4S/tqyeFlnYByTO0+3HfA?=
 =?us-ascii?Q?AfHcTkzZgR2+idovf4x+lYc8q0jUWKWaJeuBpD68gNiy2blatH5RC+/Fk7ue?=
 =?us-ascii?Q?pk0lj/LmkJyukyDy0UUzlUkcCmtCDyHOWmy/lYNdGOZh6NZl8xUbVvnKpx/C?=
 =?us-ascii?Q?wAFT7HXqRSCwssJmotS5BNncnsdSOvSN/uVuxZJR1ZJl4l0km5NQE4EL6X1g?=
 =?us-ascii?Q?XiSkklxIGsJ4AlCYfkERoonmDKvZ0630wQ1N6iLpQHD+i3oByMpYxmXIaZve?=
 =?us-ascii?Q?9e+7mE+HVC6p5Lu6ED3doFb7Xajb6rJOaoi8Iffy6i53edEfFJlwCP0SPlnN?=
 =?us-ascii?Q?M9tX72/w5c8uUN3f1Abnuv+y5ckrk7BgtUUV+uAfEg8GQf5yiTJ9ZBveDFvC?=
 =?us-ascii?Q?6RZ+Jsrgoa9vdsuEI2KWUNSVnjkFDxTsuHC30AhwWLeUo/UuiRHq0NUYKAgR?=
 =?us-ascii?Q?Tkl5xC0gHiMb3JCFOfdu3FH/NKYw/jplU96WkUNymcyY1DXflLGHIl87PHyZ?=
 =?us-ascii?Q?ffSDWZoYYfW5PbWYSavdtZZgl+G98n/yauwkWm3Rih3ihREMjzyUEMKP6Nki?=
 =?us-ascii?Q?C+Ja5QUPnO9wX1FOxBe5qosp/kvpWTxVE45cv0t7cO9l3YJ2J6teSPyqktHy?=
 =?us-ascii?Q?aIOg07STdpeKdzQQMtQ3aiWvXJzxeOpTYega1A0r/dkGSPD8Ao9N/UKPxiPl?=
 =?us-ascii?Q?Lx9w2Dq62curf4FpXaT6uloKmN5u56iHIDmCxOSvvECqv4YT1l0e0zW2sPff?=
 =?us-ascii?Q?uTgSHPjku+TVGoX9zxGRSxabtobTbNvCHVQIeP23fhW7n7w9OCEZvoiIR602?=
 =?us-ascii?Q?eismeohlql963Tq30jizRcWVPCt/TlISnztDsjWKId9ujhHp4/MLrskOEzEg?=
 =?us-ascii?Q?J+UO5s39cXr7BD/z8pAJtAR2zRDAqBkciBhGSgPJivtoToW59Uz7FHIJ+8/L?=
 =?us-ascii?Q?JAhRLtaIQarJ3KM9GZXM+FzO9AafFBIA3WgCGG/b8AkOHkNFmN9QN5C5JT8a?=
 =?us-ascii?Q?gs/nOj922Bs6yA5jJaXZ2mUkaZQNh+qFKsXswZnjgMVpQgr7dx7/AwGmWrEK?=
 =?us-ascii?Q?k+MYtmYtp5bBy5AuyX4ZRuzKIFhOGdF5wqrS/yYz+bLK60oYLGJNK10JLexf?=
 =?us-ascii?Q?qp7ibfuCQaIh170tfyWacz/RJ99NhBuc4+KIM2nvTp/LmcdbedxjykCU17AR?=
 =?us-ascii?Q?aupvpTseNETQBe7wwD3DfPtKpSsqYHDMCqqD82BuBqVMDQe7imvtako66Yle?=
 =?us-ascii?Q?dCsU4HEowRsPdwMy3uwsbi9smcAwgfjk0WZk3aH2oBQTHDciAd8pEjZ+iLVb?=
 =?us-ascii?Q?emBastP6RpIalvy5PeInRIGpysfk6K4aOb+OKn6md+6pNhkyz7U8TA0Ojv3u?=
 =?us-ascii?Q?OZ9ESdc69MNCS0XE/5G4rfqrMN6G6RAT1CqCANoM4yi98Oa3S+6maqBx0++L?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d831e21-6f95-4805-3ea4-08dc609c4363
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:12:24.3444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+eWBULsbPddnZPE6tjRuFU4sdLpX2qQdUY1LTWDh4KuvmL8PlVZ75FhvzBwc7EOcFv4Gha1jvppABEqx5vTOPAS2q/e0d1/wWviBR3qSMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4691

On Thu, Apr 18, 2024 at 04:10:59PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Per CXL spec 3.1, two mailbox commands are implemented:
> Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.9.9.3, and
> Release Dynamic Capacity (Opcode 4803h) 8.2.9.9.9.4.
> 
> For the process of the above two commands, we use two-pass approach.
> Pass 1: Check whether the input payload is valid or not; if not, skip
>         Pass 2 and return mailbox process error.
> Pass 2: Do the real work--add or release extents, respectively.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 394 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          |  11 +
>  include/hw/cxl/cxl_device.h |   4 +
>  3 files changed, 409 insertions(+)
> 

Reviewed-by: Gregory Price <gregory.price@memverge.com>
