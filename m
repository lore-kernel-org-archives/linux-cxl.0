Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C415B5
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gyk97nLB"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BDDE5
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 17:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698195357; x=1729731357;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=a6F0LWAZF5NlP42vZqotAwQnfmSiFhHvLWio862YZeY=;
  b=Gyk97nLB9JZCsRkY+V0AI5CNORBhPA5RGGAqrOZj7d5s49eM3m22+0iM
   tiDg4sgNhNsyAp2D/Kr//Amd8R4XUAdNI/Fvd/yuEiwdpZ7VK8Nd8/ean
   7HUoUtthllPvNC1UC1R1zC5NY/dGw52Me8PWoB28qwaLe4NLGWbXjeHvh
   SkmDia2oocYszMAvRaFxi9U34PSTs7skVaPH78D5JLgHENhCI54tSwHhj
   tLyHcb1wntKGxQ40kWsx+jjWpaZ7Lv6NugkJ1rz7qqqm1bxbZlzsC2b4f
   gJ4T498dCaokDi7sxi3nkJeWzLvA32bYVGkYT+OcGsahM0BmvdPksL8gv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="384420175"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="384420175"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 17:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1090042889"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="1090042889"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 17:55:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 17:55:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 17:55:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 17:55:57 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 17:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUx5KTO2gzttvZceSWP4Mg5yWUJ4LbCnkr+anOGuNPej/ixqsPPdSZAihGz0WwyF6YI6t69XsIQx0dfZZgWJAJwWIBDAJiSBbyoE3s3DkY5XrpMlFt4ImB0UL7yamUdPHSrlFsHyAzjqxZbizq4+JfAOZzZ+NWYJ4H6CZGX5cO2zi+XCRfvkGvvA/sdSHZ4Py8wHie6KWPK+uWEgveOc/5yYmx/io/y4neVLuaeejbefY6KhqpvCRTvQRYHSZnFhyMmgSy+nMoPvBxJoBWEIlaO6L4EQOeq26d+N9dwOnbi9cN8wUgidfP/d765aaNS7kNh5eHWsCM+2/rJS1ExdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clv61f/aI972r+MKlvEYRD+/1QLHTDzKB3OBOezEjAw=;
 b=WkqQyez/cOQAtBpQSZHhGZlmGNYViQE/z7y4PcWmRV4ynETzLAbIMZ0lAceZob1Iwod+QgxVRi068SERbf+CIrCjhfEiJeIlLE6uaezPni2OmQf42iqk5XbMhyxbajRN7IYIS10KKj4LH5CK733Dssv9fSTMw8fw2cwVbSD+XsgFxnLgYjxQ9JSY28biskXoSuXkaY8r91jksj+/4lBm6H1Oq8oEl8PKKI+7ZU+i2piYYCb2e+ywTLVW2xNUFOyCjERlKz2rIzJbPoRyH1/dW74Qwk9D3R3jPWQbU/qpaoji9XnddzFZXBxJV+BwjMLai6VApbGlLfo9Kji9CwxDcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 00:55:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 00:55:55 +0000
Date: Tue, 24 Oct 2023 17:55:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jim Harris <jim.harris@samsung.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Jim Harris <jim.harris@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: set root decoder granularity based on region params
Message-ID: <6538679925e75_72583294bb@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20231004230826uscas1p2f7957bf868a609211271e30ad8ff551f@uscas1p2.samsung.com>
 <169646090522.666328.17608442776078591123.stgit@bgt-140510-bm03.eng.stellus.in>
 <651e0eddb7f6c_ae7e72946c@dwillia2-xfh.jf.intel.com.notmuch>
 <A9AA55AC-F925-4B7F-866B-7AB849CB6F36@ssi.samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A9AA55AC-F925-4B7F-866B-7AB849CB6F36@ssi.samsung.com>
X-ClientProxiedBy: MW4P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: a3829898-cbd0-4afa-eac3-08dbd4f524a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oPll2Rv0omXq/ASiY6+idZqG2Vj+byr1/0DubpT+uxPJTKTm6rBbQFrde185zeGXtE7UAkZ6gvZtEu8zuq6e3tbIEUpkZ2lbI2QxjmOpYgLKNREGG9bgyHk3WGt3QvQV24tmiw0dtYVqQsavJllccvUccYG+PADT5OSwFfaanJ8xyO+U5IdcFfzePnzJNiOvUr2P50NZrera9dGXnSn3xlFCiERfW/gQY43MyKfmu7XYevrkCN4oTqjxGtQieOJsJuqK+OW0nVYR7THVhPbwvJR37FwC/bMiuK4ZagzbIghS1YbpbKxtlG9xcL9UkCd6aCFaAfToGN4dR7bAOgLiM7zjMc5Qj/lZK9Anh5mZA8KdR+QglS5wIzAbXwG/H4fRfIxO3GUlXfuBnXZVBLszdyGx+QYiDMbjN/xX3v4GUGPtRPQdEyBDjYoxpjRqwzfsGjxxwRb+eTEMpS6XXZz/hVbqzHVdOIAk734IqubAVZlgk2X7FoHxPMaeBEO6p995dem8Lq5I00wxN/J1rEzE6FaK/KmKZ0PMp6XnuOfGDIVny3c0vs28C3em+kGINxM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(38100700002)(2906002)(4744005)(86362001)(5660300002)(4326008)(8936002)(8676002)(110136005)(478600001)(6506007)(6486002)(66476007)(41300700001)(54906003)(316002)(66556008)(66946007)(82960400001)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2x6THFxdjFpN2xvMXgyU2ppbmNpYWUyc2ZBRFIrRlQweGJqa01DVXdHc1ZM?=
 =?utf-8?B?U0FwRHF0RzVUbXRmZjJ3TnFPbXVVNUVodmpUamYyY3NNM0NLdVd0VXlLKzBk?=
 =?utf-8?B?NjNvdVFHb1V6eWIwbWs0TTBiSUwxUHh1ck5KV2lyN09uNnpwSTkvTWd3MWlT?=
 =?utf-8?B?NGRPcXJJc29MYlJMT2s2TzI4cjF3dk05bkUyZExRSS9ZQmc5U2RlNldjV04w?=
 =?utf-8?B?N0RBVndqRmtUWW81NVdWRS90d1pTaEVwSUp2V3Vtc1N1WVN4VWU1Rm1zbWpC?=
 =?utf-8?B?cjdXQUdMdElzQ3VmaHdlbTFwOEtTd3c2V2N2TVJ1MEhCMVpDL2I0Z2NQZE9v?=
 =?utf-8?B?YjcxaGp3K013TktVaWRQcWdCcGZISGJLTTh0dzdOeENDWTVTcWdIYldFSWFq?=
 =?utf-8?B?NEFvdytMZmxsd00xeFlSb2lUeGdZTXkzOXZJUndQUWRpRUF1eDJFUDM2OWlV?=
 =?utf-8?B?NTJqVkpRNCtVa2R0Y2RFbUgyVkZHdjg2QU1Bd0FtRnNLanRhTGoxdnRmVHN3?=
 =?utf-8?B?dDA1SWVPZEdONUhOOGFDVW1sa0R2QktjZ2J5UmVHc2h2dWp0NDdIRjhUU1RM?=
 =?utf-8?B?ZTZJcUIrVE14MFdrM0VxTm83SmtRMWhLOEhtcGEwODBWKzZ3czR2emhyYmhu?=
 =?utf-8?B?SzI4bzRLa3g4cHVXVi9VNitSbmE4N040OUUrSWRnWlFlRFkzWENCU1F6UWtk?=
 =?utf-8?B?WElBWklmNEg4akFsYWJFZ0FiSVJ6a3plbDczaG9TcjF5N002SS9NN29hUFN1?=
 =?utf-8?B?V2J4WkdTRVFtbVk0LzU5RmF2Zk4yR2xSRllSc3BHejR3UjNHUWZrcmd3dGNH?=
 =?utf-8?B?ME1EQ0UydGR3YjZjMmRsR1NmVG82R25jKzRDcXJJT0pXaGF6OFlkb2J2dVcw?=
 =?utf-8?B?angzQ0V3TjdHUlpCTVVISGRqZlp5c1dkU3lnVEZpZTh5S0dXbjRJMEtBTTI2?=
 =?utf-8?B?ZE1IckJ6Z05WS3BSdjNMY1dEMjFMSFVNdEhpMHg1YkNoTDk0T003VTJXMXJz?=
 =?utf-8?B?Ly9tbFl2NFlqZGc2aWtjS2Z6dXFyeG5PU2lWc2E1STNVWTJkVFBJejAwMHZk?=
 =?utf-8?B?M0ExbVB6MDJ0dmp5L29XWnRBRkk4NERySlM0TFJDc01laVhrQWVGdVo0YTZW?=
 =?utf-8?B?UHU2blVuSWpva3hEU2pFYy9JWnJDSWxaalhXS3FxWU9VUGNwbmYyd2JJZHBM?=
 =?utf-8?B?NFd2VE0zaTkxbDl3YmV6Z1cxZWdXU3BTanlwSDZJQW1FN2xrRzgzc09ya05m?=
 =?utf-8?B?MVN0OW5qZGV0dEc2OTVpU21sM21JR2UxY2VFNitpTk9aQ2JoUEw5Tys5VHNs?=
 =?utf-8?B?VG9hZ1kyY3RDL3pLQUlTcklqVTdGN090YjZlWG5MUXRpcW5CT2Z3WlNOTEND?=
 =?utf-8?B?TlZjU1dUamFhTDBzY1ZJYXZXamhrR0hzL0ZVT1BKVG1XUDVBL1UyZ3BFTHhG?=
 =?utf-8?B?eEF5dE1IRWVaU3dVTHJidWZkZGVBY2Ztd3VDdDI1Z3RqRVV4cG5pUVRud21l?=
 =?utf-8?B?K3J2WUY0aHVSQkNWZ3U4MjhCbDQwa0FLa01sWmh5Sy85Q2pwMTREeVpJUE9z?=
 =?utf-8?B?dStqS1NCZW1mMll6Q3pHMjNVbGw1OXMvRWNEZEgvWU45ZHlwalgxM1hzS3A4?=
 =?utf-8?B?OEZWTEFIaFp2dmg2N3Eyem00ejhERTVWa1JYSGtiT2xNbk5BMUxlUlBnU2Fi?=
 =?utf-8?B?Z3lRczBZenVuWFlLL0dOQWx1akRvYkozdGhsZDVUa25iQXRTWWtreEUwanhw?=
 =?utf-8?B?c1F4WDY0Y1NBbit1VUlkUElLc0hVaE9PQmlQSjJLaDhOOXVId3JxRzVKSDJT?=
 =?utf-8?B?WHNORmdVU2tNVCt2akMrNE1ZcEIza05KS04wdmtRWC9naXV1bkYrOWpja1h6?=
 =?utf-8?B?bnBaNGg0UXpxQ3BnL0VXUzVoWWRYakJSRXNFM1Nyejg2Z3l5VTYvM09odm9K?=
 =?utf-8?B?YUhrWW9qeVRkRlhhczROSVNkbDIwai8yNGgzazJRaFYrMlNvRXZ5WnpvMGx2?=
 =?utf-8?B?YzlHc1Nwanc4RFlBUDVjR3lNdHYwckFzaWF4SzVHd3FTNmowbjZsS1hiSjNq?=
 =?utf-8?B?dUZSc2N2WUNXSlRRekFQMS8zQXQ4Nm10TVlCMThOM1MyVEM5aFVIRlVBQ1BN?=
 =?utf-8?B?Z3F3bENBK1RRRTFhYVNpUkZaT1pPVWxoVkl5aHV3MmdDSUJIbXRTMFpFempE?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3829898-cbd0-4afa-eac3-08dbd4f524a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 00:55:55.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wm2+6EMqvQDuGdMug3o7N/Yw29oYIrObgGhLMAb9rEFPTbe/fE8AhCyCurQZw9egdAt7YYHQm1zvnek2dQS1xO0TFLR6Hssjd/BUSeoJjBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8712
X-OriginatorOrg: intel.com

Jim Harris wrote:
[..]
> > So I think this is only valid in the cxlrd->cxlsd.cxld.interleave_ways == 1
> > case as interleave_granularity_store() forbids regions that do not match
> > the granularity of the root.
> 
> That’s correct. And now I think it’s better to put this assignment in
> interleave_granularity_store() instead since we are already doing
> root decoder related checking there, and we would then just be setting
> this granularity once instead of once per memdev.

Did you ever send the interleave_granularity_store() version of this
patch? I can't seem to find it.
