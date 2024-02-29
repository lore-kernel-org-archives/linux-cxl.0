Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16B120DC3
	for <linux-cxl@vger.kernel.org>; Thu, 29 Feb 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709246122; cv=fail; b=didgUV83JdtiXnN/Pp28mXcKb9CkH7a2cT8WMdvGBPCTQLm+FgufCbKcMTqZaGm44HMc1FIVl+GACB3BUn5qsPOw1gUPvlq0eWalY1d0e/3x/P4GFE4YKk1MQPsIpLiwkX1+jlkgJyteobWTckwXu/vaJL3E8eT5TuuA736UOp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709246122; c=relaxed/simple;
	bh=eLreZqgMr+z3rLtz0q2MT2fyiWBGClh8DVTSfe0yTZc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ve68VNNXUGHhtaH1vEJb24+eFOLdrGRNZ41O534A0umQ+mON8L5CDzSYQdbNJs+dbfX+9TaO3v2b4dhSoUKG4lX7tj+6k0I5QqAEzRl1I68ShU+7/6VZt8IbuyX3yR6yNRaYUdAhlL07gHHDRzu5wJIe8J9CDNLAOD1bxrFmp5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oD6QwZgB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oD6QwZgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709246119; x=1740782119;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eLreZqgMr+z3rLtz0q2MT2fyiWBGClh8DVTSfe0yTZc=;
  b=oD6QwZgB9inMDzy6xOisD+pjX0js4QoOYDOqOvtaMB0hZpUvPCv2tODv
   CoF/mw7WjA7V/MPOM38O+L4+5MYlAscHk9dCv9z65jmF8X66PnbccES/0
   0SevnnoMoZR+wrEU8E0vKS0PWPTTCtNPlsm7IWHrv3Na+j6veG6Duh6a1
   tT003JuDoK8xnR1FXuQApF8jkvRAo79ME3lZ3pfuGTtt4/Sp0wHWfUu8T
   rJ49HC1OIfFP4COpftsjhOHceG68RZMWyREfMR76ci6lh/3Q5/AhjQ55r
   jtNILIQusPmxMkbw3dJ9/crfGQZlqB5/UzPP10Tu7skwRQHMxBh/GXzE0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7577095"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7577095"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 14:35:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8372774"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 14:35:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 14:35:18 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 14:35:17 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 14:35:17 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 14:35:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUpu9Z5KZbZ5HwyD9O1gusG2aTMdj/Br0E41NHnmEOc7lA0kEqLiItpdD1srdEp23ENCAQgL5fjCTVVGPvKb151I+6xmp0FJK8B9SNzrWkXbdpXfw503/RvAd1Y7j1TTmNL+/+jgJxmp8FPWIEvAEXubK/OeSVpBVegjiCOnVkcMk/UveRPLqAGQzCN1TCjmzSw3G+WydG7np8KJ69S+O8P2AEFRIYeucdd+iID1FjC1JHj9WMiHz1T3ScCoysua2Piu9qX7ftf6xJxERwgarnThrrihpDPYZ6eMgd2/FfOaW9r9HVrFVNNGBVALYKbgOGlOLrA59jE/UFmYV7RQsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvQymPAFPiJ1Vn9heY4bQliIEIC+xRpQIL+CRE8b0oQ=;
 b=XUiVv+DhpEMl7mOr8HHTYS/lwdV7uR1NtNkd2kVIZIZ30vvkO83MNcR6MOZxJxcyrKSUWenUds8eOlAM9OLrohzsMYQTB6186lomOdf39f4XVaS5hx85AFi34DkRccPmhaNoWlN3xm4YDV8DM34NNiKSAkaP1i7I50bCvGool4E+rm5tpELvd69QuJBdLbizx61WXL8BYt2i8R8dr98jjc95yhdeevj71P+nFvOq3ALP7iaMz6SdYV0G/FpNCG1w+sKiJRFlKQ5k6APEkE/wDpLJ+KoP4ZpamC462liaxHzePcihw5oxPSf2O3BYJ+x990fjaVTw54AX54pgXMcJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.16; Thu, 29 Feb
 2024 22:35:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Thu, 29 Feb 2024
 22:35:15 +0000
Date: Thu, 29 Feb 2024 14:35:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 1/2] cxl/acpi: Fix XOR 3-6-12 way host bridge look-up
 calculation
Message-ID: <65e106a0e45f8_1138c729462@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1707891715.git.alison.schofield@intel.com>
 <0eebc96f0e36ebc74b0dc0f4112b70cced6907a7.1707891715.git.alison.schofield@intel.com>
 <65e0d0b7bd91f_1138c72943c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65e0d0b7bd91f_1138c72943c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:303:83::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b3972f-7861-420a-ed51-08dc3976b2da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPSI2d0KNsyiCpP4NP8i11VlrDrjHhIumB3UZ6gcN360FR7Nc0VtHoFqircbxZMDtpNsph1/BUNg+DmC3dbzVU6iu5O8ZUthfIe2wG3e5pN1c9pGGj+KtFa5f/vkjPlvfeer9clmDva3sNFDjLNwdxKDzjv8NY6DCfdHHFwk4eFC7mQlhShu+DOGa5riO0oALq7oENnK9NZW8Mm+5pUgFfkYDACi9OERRxTj10b8xqr+hi8qwF5fo4YUgYhLIIbEKa3Ifh9QDX7meE3UImM3JCl83uBR7RMdnZ86ErnE7SReCC0B23Vs1F4kPN26IFWZtvz4xBSbXS1btLaWsVRqzXpC0SXL/qOH3zcFwd087VGwnW3/Ev1Y3xYkOFaLI2K/lJWgBGOm1bTXY/qI3Wl8P/Ws7jXq0R5aEX2N+wdRTZ7M8Zy1AZuU3qKdo/6d3W1psJ8BitCr6oAz5Vp/5f8vjFjeQwIkcSRnVSdgPUMf1Nq1eKzXoIHfgFG3fI0nziIUDVO5RNeSl674NTxVg9NMJkf+MihrM0PX8DhmnWzoeXpQu6DjnnzK0vPn5uVzgu8WrZgQxzlulroYOSre3zMyCZd4htNOPaRtPzsLd7xr+I57VybzSvoeoYS0mYOdlaSphNtmOgFoBbmVtEXo+ocd6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KuQ1Mq+tbXaDbnmnu5wbnLwmudD+m0PuOvsxO3ZTnSy/uaEvj36YcVMR2g5z?=
 =?us-ascii?Q?LoB8BICyDHhkUaIPU+FO39E4piWSg8nsYZEIonWmuhVDb14kidUBOBM9ieyn?=
 =?us-ascii?Q?4ZVUMUhmAwoXdVRX0wRzchlo6DQ3qJy8AM0xpnOEDo4v2vxH2kQHtyzYe3Yu?=
 =?us-ascii?Q?XNrgDHVFtMQsVW5FZOEXqDGT50WNglTE4hmwORZw9+Q9d/hfNr5GEMInKN2u?=
 =?us-ascii?Q?fYh+BfuKw+OJc17qGsO8PgpM+BNebbdu7vJoyKI7afgL5dDzq9CFjDh0d/df?=
 =?us-ascii?Q?aq8wrb6ChBUzVOWc3ulWYha6nOu61anSF++jqC5HyIZ4QiDa1xiIXEel+vBn?=
 =?us-ascii?Q?Q249tKYec1vBg0xRc6O5DsRs11xaTgrqjmnk/r+wJj1pQKy4ilJdZPr6qKnt?=
 =?us-ascii?Q?amxXptqMHhNSBMOo6Mi5Tlzx3i4x2C0MDC4c6MJ+8OHzuLToIyaxdE0Qd2c/?=
 =?us-ascii?Q?bq5o5F1rPoYDUjemIWbm3a+DJKHXmTatKhQk8lZkcWDI8ej+e47UWZi+iqJ/?=
 =?us-ascii?Q?0dUTy9lTU88K39RkqxdKBPZadVQVAZKo2rCQv4xpXSW/aTmOZzYls9AI9fpF?=
 =?us-ascii?Q?Z4qbXZb82v5/uKVobILZbj3ZGbg1zp7Zub+C3oxxrlYKGko4LIrwJb0LCP4O?=
 =?us-ascii?Q?dMqztKEwOtafhCpJzvTeGYdKwHpRCynvN6VjUPgLP5hGv+6tPQhrUoxzj3fn?=
 =?us-ascii?Q?/d4Vpn7km/T3VzY9GM3pCBKM/py1yJV26M6wBrg95Zw+QM/vYBxfRJcpbSyU?=
 =?us-ascii?Q?NU5gL/vx1J9TlqnHu0IuYzKnwZ2b6oLGeNj6lWzftGri2wDBfRMHwHrlgNUo?=
 =?us-ascii?Q?UgCHikkBN2ZLXjt2ckRyLFoqnWX5bCdyBN6ByvO47OPAGam63UwD9eNClbNf?=
 =?us-ascii?Q?2atQgak+wDPGOs9iURtWfmbhcUQstkcqaaHJcKlGSaDkntzGBuZk6GPWr0f6?=
 =?us-ascii?Q?MdommZo2a3dEGlPiGlwONvrtJSVRAaCNtlHSFFHKlCRBsSpNyrNMHBvYel8Z?=
 =?us-ascii?Q?7XqB42+HGD6B/5qknvm0XuDKOE9KwTAaB0OncuMa/2hwBW7B/lwBX5M/bYJE?=
 =?us-ascii?Q?Tkr8DQVx1/5Rdd8XWUoqhhlof7KnrNzaXbxpiongj1qC+zBCkNxNdy7xZ48k?=
 =?us-ascii?Q?5gFvjSmkf9wngtFUEwSaseMxWLyRVyWkaL2xXyBnavnjvZE1vv5iB92Vr55f?=
 =?us-ascii?Q?qap4q19aRL8XVVE2SKebNOl6380bd+cuOb/nI4eAJBM3FvBtPha0I9QID+k+?=
 =?us-ascii?Q?jyaqGUf543g55FBv7QBv74/J77uj5XrDzowIxKUeW4+EWhRi+Bcc7HLKB326?=
 =?us-ascii?Q?pDk72P716hw0uH7JIKhywUvMyD+fxrXyQCIEj1pQizvhlXWqg9Eg1HE3+FrK?=
 =?us-ascii?Q?cSLE/YlB0pR0sr1rK5CvPmSOlONl8KyGUqMl0bOxgOVwq8ju9WEvu4rpaYq7?=
 =?us-ascii?Q?dCV3a6IF4Rtqr7tECN0YUekhPwlSqos7kmI/ClRpjRnJWMv5gKPQSMiZTSIj?=
 =?us-ascii?Q?XHs76/GleTyO8+CahnLdywZWWXg4q1tBVnHilzv6vK3diwTc0hPV5DMPj2jE?=
 =?us-ascii?Q?XIu/tJY0AdEKZskNStN2Q5aVoqskHqJpsmg19PHQxxBYwsd4PdG0ncn5T2n2?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b3972f-7861-420a-ed51-08dc3976b2da
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 22:35:15.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyAgHAKETCa2/TqwxLT95BOy5HpafygkEj+RYrtYkqdCykatQG/Y89EJ+UF3sOeht36TxTp8f1+iJWi3ydXzNXubvytK8QJWLPa01gzXGWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4514
X-OriginatorOrg: intel.com

Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > The XOR host bridge look-up function is broken in its application
> > of the modulo calculation for interleaves that are multiples of 3.
> > 
> > The failure appears like this:
> > [] cxl_core:cxl_region_attach_position:1433: cxl region4: mem0:decoder8.1 invalid target position for decoder3.2
> > 
> > Replace the broken modulo calc with the same modulo calc as used
> > for Modulo Math. This is per CXL spec definition but was overlooked
> > in the original over-complicated implementation.
> > 
> > With the simple modulo calculation, the jump to a helper function
> > becomes needless and the work is now presented in a straight line.
> > 
> > Display the interleave_arithmetic in the dev_dbg() of successfully
> > setup root decoders to make debug lookup easier.
> > 
> > Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
[..]
> > -	/* Entry (n) is 0 for no interleave (iw == 1) */
> > -	if (iw != 1)
> > -		n = cxl_xor_calc_n(hpa, cximsd, iw, ig);
> > +	if (iw == 6 || iw == 12)
> > +		n |= pos % iw;
> 
> Can you help me map this back to Table-9-22?
> 
> Shouldn't this be:
> 
> 	n |= (pos % iw) << (iw / 3);

Wait, no:

 	n |= (pos % iw) * (iw / 3);

...to match:

 6:   + 2* HPA[51:9+HBIG] MOD 3

 12:  + 4* HPA[51:10+HBIG] MOD 3
