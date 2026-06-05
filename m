Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B951530D3EF
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 02:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780625094; cv=fail; b=BvaB6q0g1Yzlq6YsmDlDwj9wLZvhUZWc+JsGmC8nPuQ1TausGYdyEFJD9ErOb2rtFJnDbxmBviPXiR7ysdS3MSq9RB02r7+zNqEjPsR/3UTX/8TiUfTSGOdXMLS6G254Qzz8TTLasMzch39Cd1BwPNoyFu5vXlv0rY45QHIIl8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780625094; c=relaxed/simple;
	bh=KH72f9W9pNOkleMw84pV/ShxaTu91tzInE3MJRYdsh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h/Pr9wS4uzi+OxGXgFHdP30OlZ07Z3XbyT4yTHkVfDIHphqFRWceuUGufj7UHV+kqPOsavIuieJ5+0lli6cI5ODFatl5TRFtf9b0l5tS477GGydHbdLS77PIjQRfSrY3bHUu+g8BG+5YhUNIfefRURGqKqPdhp5qVsxlSi4f0BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hNCgcPVq; arc=fail smtp.client-ip=52.101.62.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hNCgcPVq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAAByxgxvUAD7xN1CDhbjjj2LF7n4oiPny/AOs6Gs0q7W3iliXecigQqUfUrLyKWym70ZGn5v1fp6yozqnAbIULIckufZVTdO6kuBo84G7wj6A9p+6SW7mM0tg0WbU/c2E3a1hLeG+dJPxy19bhaaI2YUTUxTCw5XShh62oNk/V4Sb8cGx29yR5wfRWf40LwIOMxymG1LmuQiYl6VXZHRDf0dFYjED6lk5jlgrwbnWRsSxIiiRObWZuAvfDcITiz0lN+TDAid30mAQFuPwH6eVD/GOgcH6kNT/Sn/zDfjvr2Gi970BLc46w4x+EMCOT/G+sseCeKUoPmklU2ZkqvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9Qcp8nuv2eWxDPnH+xFYVQ2t6ga0j96oneepZEq3zM=;
 b=k8fnh05nwUmHbuVQhtLEKnhUbD2/wnJeq8a3ee2+CDrx10quFkVMSDtGA/GC03Ume+obyPqYtZGF7Z7csbZLRpNmM0F9W5DeXqYOjYF23HpygLi+zSbwgdy1jxkAzQJwHrI+QLTT6l33EFsy75J7H3A0U0XSZWWjkQDXnpobdV67pSwINAuM/MhHuXaahjTDLCQTzn9q2nDSfiFutN0GZL4S50OUDIFWjFn3ap9JTg68Mi2dE/bDiOjL+38/gq0yyCQvHZx5dBvq4bELTfagSzx2gcOQM6X74kg9MMy6piqK8SxDLlFXfP/l6dsWvmgzvP4NrUdbyP2gCx95C9Cojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Qcp8nuv2eWxDPnH+xFYVQ2t6ga0j96oneepZEq3zM=;
 b=hNCgcPVq2Dwo/L5i4eeBG8MSRsXEc6fdkjQ63/S0bSubfaOvuwLtVJ4ZFUQSoc+tbxejMoRGDsGtllKA4B1fjsOZw/nN8CLNx3Wq9ZNPZf9lXtke8ND+Z8REcYjujKpAvBW4Jsr78PHs/q9Ad7Fq/UTPVgK3Mnh31E4+CiDP/ulKoW9rg3Fo9e6K/k2+d4WMO/g7sLuC3CtCX3g/zkl8lF5l9FRiN9O51vaqd8adUbE+jLzsglKJrhI6poVQcpd8TpFTYmOLBGeU7voG+h1umVrFan17mMBW62FmHgfoDw6+QU+CGnRGm50H4P5VUSykrcAiYy2Gg3kL0WYdrbcHWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 5 Jun
 2026 02:03:19 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 02:03:19 +0000
Date: Fri, 5 Jun 2026 10:03:11 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/5] cxl: Add BI register probing and port initialization
Message-ID: <aiItL9wmNPDafyFG@MWDK4CY14F>
References: <20260605003329.2584012-2-dave@stgolabs.net>
 <20260605013307.DA9421F00898@smtp.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260605013307.DA9421F00898@smtp.kernel.org>
X-ClientProxiedBy: KL1PR01CA0087.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::27) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: edada9f0-26f4-42bf-b39f-08dec2a69d47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|4143699003|6133799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 xT7x53GsCFCN6e5x2HsfT42DkhKSN0yQW6SIxMgYlpYZ+Y9ROEj0XOCX6w7rYCWqpxurXnRaUOmWcrhNVIvmc8tFjOmHo7oFwYdwK4lSDXSbBCF1n3eYdKS5lY1Pz5yfj2+AV6+2ugC6BHJvt5sAXkNUeW6qI/ZQAAtzEq8LO8UIlG85+CQ31I/8mhqsONwkug1H82NNlG9/zf6JlfpFZ6acHQp0ujyp3eUM/LaEtqu34N4KjCZoBsieQWMekMjrASd8MCtFx9t7UZGUZM13cowXcpxCI/DLAq5gqvKunIQpvwgCycYnu20IXqGtaLb20P6AJkLBSqHNZJWwBEcthR1V/+8SB6jRVertiz3TprCLe5dJ0RM5lDRc2CZPrnWAu0wy+NGyDekRTK/eGLiIx7snEF93o7i1bl+Mz3QOFas4diOxTKn2OeL04zr/oR3H4yXWLi0742s+CxMBh0O7A2iC18xDiL7nbYZUxwtJ87RufIIaRvdAh8/ADVG7P8UZm3EGJq+xfQhU438gI8IQ1rt2F/D2lesZ+himSJ/a/52bJTrB3g/Mu5WqdH/x8VwHQjlPtJAslEkHVzR2Uuhte0O95ITRP2G9CocCEwgB2N4PaThC79Tx9PXlEO6GOhAwJtQ+QFTkoNR3rgq7yo5htxuCOvxWfMJtpqDgsn63cWHgnmXuXCtDLVq7NsxzgVPw
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(4143699003)(6133799003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?a1NIVVVSYjM1d1lsQnkxTnJwOStZUHVQeDc5MGk1L2JaMUswakRWMUJCc3Jm?=
 =?utf-8?B?M25wVUpJdjVGSmxwY2dOTlBLZVVjT1M1V0N5T2dLeDJXRE9wNHg3REZtbDJm?=
 =?utf-8?B?V0hoaThsVjI4L1UzOWo5Sy9PTkE4SWM0dzRUZEtrZ1NLeVBJN25tUWora0dT?=
 =?utf-8?B?TmdjT252UDRUTHZKam1RMUJxakJDTUJJMnk0Nm9PMFpVeHUxdkZ6ZHV2d3lM?=
 =?utf-8?B?ZTI4SFlIbzVWSzM3bFNlMkQ4bjJSaDhDZHkyNGgzYUlwSFNVU3o4Ukh3d1k5?=
 =?utf-8?B?d2dseDFhYWh5MTFKZWt6Z0ZwRCtSN3B4VG1IMHRaQjA3WDNkQzF4cVVSN0ls?=
 =?utf-8?B?bEM1U3lVYk9Rdk1GSGwxa1lQaFFnS1ZYOGk4cXVaalNmZFFwd3Z6YW5OUzUy?=
 =?utf-8?B?YkxsUExNck1ZS2VPcHVwR092dnJxTzRUK2RnNjk2Qysxc2oxOFRHQ3hRVCt6?=
 =?utf-8?B?SFY2ZldkdFlEWHIwMVgxMVd0MHBOV1BKdlpldTlvdkFaL3JoYjNOVm8weEdr?=
 =?utf-8?B?TXh5b1cwNUFjczJnT2I1L0lXRnlsZHFvdEpxUnM5RzhZTlZkelJUcnlXalMy?=
 =?utf-8?B?YXpzY3BFYlFvS1ZVck8zL203bEt1VTFvblhvb3pNMVV6aFNJZFlUUUVoQXpw?=
 =?utf-8?B?aGdSRFR6R2xITE5KY21yZjR2cXc5QnQ5b1RWclN5YkFrdHpjeFJBRXlLTFBJ?=
 =?utf-8?B?cW40MFI3OXY4dUllZE5EZGNGcC9FY0IwdERGZEQ0YVZra25TZktNMzF0ekdT?=
 =?utf-8?B?V3RBelVEU3c1UEFJMDR2dlNZMy9NcjZ6YzJkQUo5bUdHZHNPdm05WVhHRko1?=
 =?utf-8?B?MEVHejh6YWlHOFZUWG50dEU2QThhakc0QnJjRGlZdnBSdUdGWGx1NzVSUlNT?=
 =?utf-8?B?b1B3Z0xVM0VCSHN5ZStNUGdtajFxakF2ZnpzT3JLYmFldkRMcTVJMDJwdXU1?=
 =?utf-8?B?cTB3Uy80NGl4Uk5qTENGWG00NmlKT05KZVdyd2RiVms3aDFBZjJUS29YOU1t?=
 =?utf-8?B?QVIvellMcStnUVFHb3VaMDZBRXhoaHB6WEsrdG8ycjA4UXR4UzFQRUY4WXpT?=
 =?utf-8?B?NjIyQWxmenl2dnJORlFic0dwUCtTUWNKeDZYZGVBRFdSYzcvOWVYNXJDTmlB?=
 =?utf-8?B?bUl3ZmIrck1rNXpXZC93UGdqeFc1RGlzSnJyYitjL1JPS3BWMWZBUnExc3BU?=
 =?utf-8?B?UHc2VFA4eUJPd1M5V2R0S2R1VGtzcDZJdlhCQWRId2syNXFOckw2Zk41MG9L?=
 =?utf-8?B?ajByVEVWcVdTZFgrVTdJaTA4TEZ6dDRDTFVSNHJqYVJYK1ZmSXBCeVpGeU5v?=
 =?utf-8?B?anEvSURBZ1BZRDlVSklwWng5OGNOYXBudkhYS2VnS1J2M1lhMXUyVkcrWnNX?=
 =?utf-8?B?bXdNSTZlditRVitaVCtxajBMaXlVdDFJNjIreGdmUGVmNDNyTkNVQ3ljTjRO?=
 =?utf-8?B?Z1NsSEdaaFVPc3lSRXJSbUN3T2YxcXEzdG1zSFJSL3A4UStXd0VlMHFGYnpL?=
 =?utf-8?B?a0wwVUM3VHgxU3E3R0JYQWdmdDRBZVg5Tm1KM3VkUFhyQTBZeWxWeUZuWkEv?=
 =?utf-8?B?YjMyMDZBVGlJVFpNK05JNVRyUXpEam53aWxJeVpSSXhKZ3F1V1VHNEpRQzRy?=
 =?utf-8?B?bkYxYXFUa0doSjRWd0dlN3dicVNhT2FWK1NzcU5BaEdqSGE0UU1rWFVKN29Q?=
 =?utf-8?B?UUpSRGZyMkpiSFNvc2NwbGJpNDdRV09EUVpVaEVrcEt2NXNvcXRoenk4WmY1?=
 =?utf-8?B?K3E1N1ZUUzEvYkNKNS82U21vS1VIY2FYeGtxdExVemp2aTM0aUJVaUNHcUE2?=
 =?utf-8?B?QW5ucDlGRWhhR2dyV1NwRU5HTjB6Z2d2QWt5U2liWEs4VUVJTGJBOG4xYits?=
 =?utf-8?B?dGcvSHpyMmdyRXYrdEo2MVowbzRyUE1nMUcvZllvWmI4Z01kSzJnNEhJUE1R?=
 =?utf-8?B?SytCcVNWRHo4SE0vOGswRlE4NEZYS0xjVTNnbW93TFUwVGNKaWVROG1rZW9n?=
 =?utf-8?B?d2hyK28vTklrMnlDd1llcUNZYi9hYkppaENsaW9LYUE3bE43Ym45NEYwd3BK?=
 =?utf-8?B?Q0VZV29JbXJsZXRWVldOMGdHazBpSFNsaTJDdHpuWVZhSCtmTWNpRitxQ0RC?=
 =?utf-8?B?RDFMc1l3ejVlallYa2V0cXdVVDdzSTFySWtQY01wV3ZzaWR0THp0NitxTnlS?=
 =?utf-8?B?SjkxOWhPa0hrOFFFdGdRb2U1N2RYRUVha1JneTM1M0xVM05IWURabmRYTCs2?=
 =?utf-8?B?NERqMmNIV2VpUDdVY2lTQ1FSTm9VZk44SkJPdG5EWWN5Mnp6ckM3UzlFVVZs?=
 =?utf-8?B?L3g1WDhKYVZsYXNUNWRUNnk2eWxURHhzYkhJN085STQ5d1lBVHdWQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edada9f0-26f4-42bf-b39f-08dec2a69d47
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 02:03:19.5942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pbVzOhX5ZAXMYale28xfY/0eoktVexIyfBVZsbgZuUwJAsJTEZlKsyDLHyA+AEIqUdGzM9+lX4namuH8HGttw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144

On Fri, Jun 05, 2026 at 01:33:07AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Silent failure to map and configure CXL BI Route Table due to probe sequence mismatch
> --
> 
> commit 34d3cc24691a25107f1dbbcc8e03fc18ffcae164
> Author: Davidlohr Bueso <dave@stgolabs.net>
> 
> cxl: Add BI register probing and port initialization
> 
> This commit adds register probing for BI Route Table and BI Decoder capability
> structures. It introduces helpers to map these structures at dport-creation
> time and port probe time.
> 
> > diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> > index ada51948d52fa..2dd712c5d312a 100644
> > --- a/drivers/cxl/port.c
> > +++ b/drivers/cxl/port.c
> [ ... ]
> > @@ -58,6 +58,62 @@ static int discover_region(struct device *dev, void *unused)
> [ ... ]
> > +static void cxl_port_map_bi(struct cxl_port *port)
> > +{
> > +	struct cxl_register_map *map = &port->reg_map;
> [ ... ]
> > +	/* map this port's own BI capability */
> > +	if (is_cxl_endpoint(port)) {
> > +		if (!map->component_map.bi_decoder.valid) {
> > +			dev_dbg(&port->dev, "BI Decoder registers not found\n");
> > +			return;
> > +		}
> > +		cap_id = CXL_CM_CAP_CAP_ID_BI_DECODER;
> > +	} else {
> > +		if (!map->component_map.bi_rt.valid) {
> > +			dev_dbg(&port->dev, "BI RT registers not found\n");
> > +			return;
> > +		}
> 
> [Severity: High]
> Does this silently fail to map the BI Route Table registers for switch
> ports?
> 
> When called from cxl_switch_port_probe(), the component registers have not
> been discovered yet. The registers are actually probed and marked valid when
> the first downstream port is added, which triggers cxl_port_add_dport() to call
> cxl_port_setup_regs().
> 
> Because the valid flag is always false here during switch port probe, the map
> function returns early and permanently leaves port->regs.bi_rt unmapped. Will
> this bypass the required hardware commit protocol for the switch upstream port
> and break Back-Invalidate coherency for downstream endpoints?
> 
> > +		cap_id = CXL_CM_CAP_CAP_ID_BI_RT;
> > +	}
> > +
> > +	map->host = &port->dev;
> > +	if (cxl_map_component_regs(map, &port->regs, BIT(cap_id)))
> > +		dev_dbg(&port->dev, "Failed to map BI capability 0x%x\n",
> > +			cap_id);
> > +}
> > +
> >  static int cxl_switch_port_probe(struct cxl_port *port)
> >  {
> >  	/* Reset nr_dports for rebind of driver */
> [ ... ]
> > @@ -66,6 +122,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
> >  	/* Cache the data early to ensure is_visible() works */
> >  	read_cdat_data(port);
> >  
> > +	cxl_port_map_bi(port);
> > +
> >  	return 0;
> >  }
>

Hi Davidlohr,

cxl_port_map_bi() is called here before any dport exists.
Component register discovery happends later in cxl_port_add_dport() and then
cxl_port_setup_regs() on the first dport.

So for switch USP, bi_rt.valid is false at probe time, mapping is skipped
and never retried. I saw from your cover letter's dmesg

"""
cxl_port port2: BI RT registers not found   ← probe-time map_bi
...
cxl_port port2: found BI RT capability      ← later, on first dport
"""

Endpoints and RP/DSP paths are fine, but switch BI RT mapping might
be the gap.

Let me know what you think, please correct me if I'm wrong, thanks


Best regards,
Richard Cheng.
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260605003329.2584012-1-dave@stgolabs.net?part=1
> 
