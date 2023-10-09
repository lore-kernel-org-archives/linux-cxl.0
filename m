Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ADC185D
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LC40HC3L"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5BDA4
	for <linux-cxl@vger.kernel.org>; Sun,  8 Oct 2023 21:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696825529; x=1728361529;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pDzEUkKI6ujhQ5g9Usevw23SZjufrjjXaoDr+myOutw=;
  b=LC40HC3LcGctOH/YSja1ynbMsNYz1J+NNZMMbzGjknLe/jg5a0jLLleD
   DrVfVXjhDvy3AvPY01gob6V8AV3GLdzP43d3PW4We8ZWqFdRi9WX9Hodh
   5gfF1ToBNuGf/L1/CbtSk02hx31jPoNbjJQw8ZBIdt2tGK3LcrI8zttph
   L5h86D03IByP5BgYMQfLY1pOumFktoG7yWQesyX/RTdS5GYuh4Bj5bKi9
   RmXcCXea2JFfLfJIN4hTWF3GQqnVg3Pf1r6L7bOEQIGkRikGfD4yqRpUo
   XK0T1MikR9dCWzSWF8w9qac4gmlCg7UofDyTm5QQP0u7YMm6IOl4OAVft
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387931238"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="387931238"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 21:25:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="843566756"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="843566756"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 21:25:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 21:25:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 21:25:29 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 21:25:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btCTqbVEGVHM7j2vn17sb5fY12DUJDQyJ1x3oORzCjNryTs2bNClPs7udXgVO1l09Z3Ort1Ib4KXDF4ptFCi8oz/y6TPBxvJx8dyoPPDN+EYSqnXRpVnNB2EkSpi94m+/7lSOP44asywo7ArnQOxocx0tor1tjyglMSF9CLawgPZjjVeGBZjDU0UHzx8dB25V6RgF54MUh1k2xM5vNvBmqgMDfBqX4/r72OkL5zthJakr1E0KVzBR6EtVI1sGhUfW5cZDdpFO38weOy5scnmK1PWNEYIQcudmjUJxPGIxs6h86OjsQr+1+ke3JlrLeUu3RIV7SoLU4U6omDo8DIRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iSMDx22RysUoRrt5KhIvLmm2jFrD+ZidWH9hGC6IK4=;
 b=PT7V1X0dIy+aJdGQW5exQqWgel85k5y4QsQM/qCL/PCJhczmN7CZx+/gg6YDSK3OyjzPm5xpWDSErLRa7KwVefw+mfDwiUoDwSiXyzwdZrijnHeazeIuBAA+lKiP0aZSRDRaHLnmbjUafsMtkonpXD2eZJD+1F7qhADn880f9gBHFGj0tjFLGsPDbiOBrtxRZCaFguGG3vlXTRAX9dlLEX7wx6PkZLLO0t56laCVzIhj90MFyBOAfVLqVKkFt4u1VMZNzHnbIIvfB8AabVXiU5fvWrI7pRJc/qpQA/HO8LSB+jBwjVKzoqOVnOlyDXSqo6lD7iyNd5OuD4wQCHYYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6214.namprd11.prod.outlook.com (2603:10b6:8:ac::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Mon, 9 Oct 2023 04:25:27 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 04:25:27 +0000
Date: Sun, 8 Oct 2023 21:25:23 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 10/10] tools/testing/cxl: Add 'sanitize notifier'
 support
Message-ID: <652380b3e98d2_1d98842944f@iweiny-mobl.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657721756.1491153.17305814762884004365.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169657721756.1491153.17305814762884004365.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY5PR16CA0016.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::29) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: e1df4f4f-ec92-49da-7ad6-08dbc87fc342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nDAewbGibBSbSPmr35awm05n5jAoY8Sh8yZPxa53wPQljobfUJzuDrwQjFPNOFjP9nZlR/HA4PWFKIEEHAro0bfuc+HgbQtKuvx0AICfVDq6NEatd9rRcFgSdJYmkjKoch9hvc5be/YJbo7vViOtWmscYVCT9n/Xf86CpJzPI/JVJvEQtm2/3CCEn1B+v9mP0iN21CaIopRdkRAeok/hl6FKdTpRswhirU44GjiSnLQ6kexWLBELWdlohnIOI4TcOll5MrfoUnulzdh78oGw4esVMCV3UJAnjzAPNrspr7W3p4yMACtYI6i6IHmxZrchfuiSX63F3XETV7/1iUEXN/w8+zqYT6bhi1AEHg//vMd/Fw+j4nLmf9Ji85XXDnc8B5ahc/XfWC+VU5TmoOoHuoIG7OB3PaPRo6suJPUMb5shC/6WT5AhEOgFmrEeIVZJd97PjpnmZ3YM+fo9ullyulvfLm4GWT506o+rudkY8WKF1+2/UylWbY5pKaMkw6yjmvbM/43jIyu4qMvVvtxPZ6ZxtFD8eRz6huS6Zcd5FpOr/TJcNpSc6iQARJ4U5fir
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(376002)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(38100700002)(82960400001)(2906002)(9686003)(6512007)(6486002)(478600001)(4744005)(5660300002)(41300700001)(8936002)(4326008)(8676002)(6666004)(44832011)(6506007)(83380400001)(66556008)(66476007)(66946007)(316002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xiRpj5DD3CGoJezd+wTtBqKwMcU3p5wI73iZ794T5naAcv1hmfCdN3bZYSRd?=
 =?us-ascii?Q?meEYgioJid2VdFlhTVnNDdFdnMfT19KIxDBuuVASiwRnGq48kbipSV80lQ5E?=
 =?us-ascii?Q?djTeFQ9QmfyDHXpuPFhZsjVxgvtw2c7/OYhl7DjJIMeINEP/TJQjz7LOuDtB?=
 =?us-ascii?Q?MBlHkSoRrwK68lGihIXKtkPthH3hJJc+bg9T1rSBQ/fn9UDyKkGslNlY85bB?=
 =?us-ascii?Q?jlN9B9CVMEo5JfD6nfUSWdeZWS7Gy7xcXmraga5bQyRqzI9AYDWt1URTxRaf?=
 =?us-ascii?Q?rWq6opBHalBzecKV3fAEvZtuq+/ikcN9RIaged92P2Qa2/nz6iFFUFDLD5ZP?=
 =?us-ascii?Q?lcfnIfEObn5ekJJ3ytT2st9nr/QDLF1yKsa0AvHnjz+kxWonTlatF6/ixDse?=
 =?us-ascii?Q?d0jMFhywYf5RBxGY9Qv2ryIrrl2IR7ts3akN3EZiH0eXz+qpltnZ0X+1Fduq?=
 =?us-ascii?Q?b02Pcr/UPUYbY3ymJpfEs4irABcpV6ht6TFP7BKpwvXlfp9RxIJg8KXaaltE?=
 =?us-ascii?Q?V0qoYw64hjx34SzRgmruDtBtqVfeSu6o0Js0I2TjxFldm4ebMX6rfwZ779Kf?=
 =?us-ascii?Q?EK8NYKogURi3vc39dEQBjbQUKAUA4rLJU1z8of5lohop6sV94jowuq7eBn2m?=
 =?us-ascii?Q?VuPrLS+vyvT1qk571u9SihFpQsVnlFtnJovVXSl1zemwa3v65rAMxrPuPVXJ?=
 =?us-ascii?Q?yTPo1zuleNzDbymQJgQsGZgIzCLnMhXXDEiECEgy7p70ZmraXsBr6mw0yi6X?=
 =?us-ascii?Q?SMJmPVPwXfUIRN49PPyQLVxFQjIxDFmlFO/yUysjfGRpXM6YPrbGvRaAHoXB?=
 =?us-ascii?Q?VDrPB56lioDLWUU3OR+msNqgPQyFgCO1FWImsOYRad0S4ZBJYHG8gCwtIxZo?=
 =?us-ascii?Q?kCFtclK/vm+rgKuc4JITc3nKCpyXRHoS7/rkgG150OaS8/lxG9w1ionjqitY?=
 =?us-ascii?Q?/WsuPCyR+8C/J0C8Egi5sF9PKwtMk5rwzJASJ4QBDtHdff7wfSdog1EpD57Z?=
 =?us-ascii?Q?3jRBIy/+P2/UeHNpXPepd+mtFb/fSdpnjlmGMqAuKg/mp/twbVM9nL7850Z+?=
 =?us-ascii?Q?OEOvvN2KIbuWvL9oO8aMcj0RDbCO9e4OSrCUk6ySzd9OvNPEWD5nBDMeotZ/?=
 =?us-ascii?Q?9dicbGYLQobPWWFuA+/+zNvpo6EKkOs4zQHdZBrIVrSNmUERUh4ojZWWRUAN?=
 =?us-ascii?Q?dNqZe/dc687Bim0hEaK8zIq9rEH5YBSeX3l8SuZoGteWE+caTFzaKKZMPmmw?=
 =?us-ascii?Q?KgLCS1MqycD6isUXKwty4TfOOqpOjgTRbH4PMk9xKtbT0yDxtZB60vGO4RPq?=
 =?us-ascii?Q?dgss/OthKW/PzunFggylIyJ6sEme3+YVsGjSTSJUA+mib+ZCy18ZN10oZb6K?=
 =?us-ascii?Q?9iKGjA62PX/oznCUpuKt6jVoHLt6r0x4PT6ud8nYZ0ICXOsLmbzTaVHkGYKo?=
 =?us-ascii?Q?MaN39QTNfySkogjkhGHaszR6KedNv7L9YtYd3+xMr0HN8ROHr2rNCtpP12mR?=
 =?us-ascii?Q?wbvsQivUCmv8AK1cDLk88vtfDfqCPN76+vAUrOhSdzPRiL06NxhPYF9KMy5A?=
 =?us-ascii?Q?kRcwGh4+U7MnTTm5Xprl42drmYuykPdD1cRsOJL5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1df4f4f-ec92-49da-7ad6-08dbc87fc342
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 04:25:26.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyCFP5zmp9n3yWoGEenD3okU2JGOEf035qQ6w/Id/x3/zQgVcERxSrNF80oz1yHxt8xB4Fs/u+8WuoCMxlxUkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6214
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Williams wrote:
> Allow for cxl_test regression of the sanitize notifier. Reuse the core
> setup infrastructure, and trigger notifications upon any sanitize
> submission with a programmable notification delay.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
