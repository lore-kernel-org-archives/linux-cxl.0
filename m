Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A80E1DF72A;
	Thu, 10 Oct 2024 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728591359; cv=fail; b=rdzxPY84x2LfmkEpf1aqw8Wg0xsBMxkqoCkEMtf9RfEY7PoddZlphIwfFY50hPoWhK8w1KdKLRgXqvpz13GkioBOVIh6qYOGzDqd8Wh67mP9llMwNGUDa+z2MUrzcCG578QfTiFZ4Or0T27goC9hYqZqdpfFamV1aTwOWAzWn4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728591359; c=relaxed/simple;
	bh=3iwEQotdWH7uhxATICaNKFueBMZlU57AIlW59dbCg6w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HTHnZgBirv6OzYG3xCMqVhTjQp3HSF35elA5KQgb5Js21gqh/lwl1RphyXt5bvWQEeqS5jHGgbUtZn0Vh0MXyi+2TXZG/m34nvFvF4/r42ToWb7wvV/lMel+U2hRgYatnSM1FdGb6FrYW0NTZoZ+kKnqBWC7HFmMpGbHUFW7e5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AufE0l6d; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AufE0l6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728591357; x=1760127357;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=3iwEQotdWH7uhxATICaNKFueBMZlU57AIlW59dbCg6w=;
  b=AufE0l6d4cCMUyD++nuOs1IXe+AxFdX398Fysku+lYDT9svdooQemE7C
   4xRJTkjaXFyRONH7giL4EGVQpSn5g2Yw5XdIJP9a9trfFd1xobTLFlhrq
   XbnyCOjCNhmvhWQnr+/iaS2pQmIM53Rhfqng+bOeuHZLnrdhVQsOCZKhd
   0/+Ik7ALWjMaS1Ox7s4H9/WTRJ3TYw0HTykHLljEFVXBFdt/SeebISnVz
   ak3Yl0EFlpNvdgBmmKW5EqhrJ0TkEXzfjXCe8sqq2PTJ+AysxorPG4xgE
   kACkXvbfuAup0ifG0nZL08OdfUz469GIwh6rb0fLTAXSXMpWp3BzCO80z
   g==;
X-CSE-ConnectionGUID: W8DTEbHWS9e8tEBpPCTAZg==
X-CSE-MsgGUID: Y4GPwsUpSEWAG08Ua6kTAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31770622"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="31770622"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 13:15:56 -0700
X-CSE-ConnectionGUID: gCJn/xPKQ/6SA8HBqrmNNg==
X-CSE-MsgGUID: /77d14hFS0iJoIC3M5N/tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="77523426"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2024 13:15:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Oct 2024 13:15:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 10 Oct 2024 13:15:55 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 13:15:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgDdWJiqGGb+1olZWyIKxeZcv6hD2+z91zbg7GFYYZ3qxZ8shEV5zO+ASqCj+MCYT/ePQyS6t0AHGPIkUCeiTvNYcRU1iim2zXnWbmNnhMpEJWht7UfDNRZMNSAG41XBjqSDwsspna8toI/OyLvFMAqf9IQVUohNh5MFC354CWjdxawfr+JiS7Bsu7p7lTUFIbSQDyfZ3pbNz36vCWlJqtASOw5X9xqwvCrfvj6W0YFvUzaZVxTRGuTZ5lAxTAvQ3d1eLRJbCRqLI3Hx+5ID+zE0peRxp56gm5UufoVB/qgUh3HOE8d88xnHJpD+T+WKM2Jf/Mhql3MYwESUc6S/EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4OrUlUmimSNVpp0ytiOFgdQXNPHgdS7sp1KMGUkor4=;
 b=AUVP0t9PlLAo4QVSgh3TtaPF12f158ApNIzUYeVYhKmmK6nyfoSo7zNfh8v1xuyESRkMsoU5h01aO1xu6jEvFmkyhaxaF5ftb1oa0gjVrpfndhFiQ8YoPRSjQ7jLsU8ecbQuZR38JMyK3kmE6UrSX+zwfBp+TzduRXdqbVbvL5wLZrtjEVfl9amW5lFhqWSiYKENRrv1t95v5OBwlkjpuLTQU/J1ByVpkYONul4SJBLTiEcxLObwmduNyxrrmzRwGmZpBttM1CQLjLjgZDeZlb9hfDFMEy+k6pPyrlZ3WJuL++w5pnZOCUXYI9/2wcGkma1dYrzY1X34QRcZ8sYXRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7881.namprd11.prod.outlook.com (2603:10b6:208:40b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:15:52 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 20:15:52 +0000
Date: Thu, 10 Oct 2024 13:15:49 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Zijun Hu <zijun_hu@icloud.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Davidlohr Bueso <dave@stgolabs.net>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: Zijun Hu <zijun_hu@icloud.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v5] cxl/region: Fix wrong logic for finding a free switch
 cxl decoder
Message-ID: <670835f5a2887_964f229474@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240917-const_dfc_prepare-v5-1-0e20f673ee0c@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917-const_dfc_prepare-v5-1-0e20f673ee0c@quicinc.com>
X-ClientProxiedBy: MW4PR03CA0285.namprd03.prod.outlook.com
 (2603:10b6:303:b5::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 30da7221-6d7b-4498-98f1-08dce96856e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M2JncDlOTno0N05SL2J2M3FlUnJWNGExbXNiZVdKLzlGSU83ejMyTms0Z0pT?=
 =?utf-8?B?dVZ0bjdnalZmWUNXcnpIWmtoTzd0bXNuS3JSM2toYzcxdmZIK0d6VU4wdXRU?=
 =?utf-8?B?RTRDRVZSdzE0YWhxcEhrRWgyaUMrc1lEdlNSRTNYdnpiY2lscU1hOGZWbFE5?=
 =?utf-8?B?cE5NeE9LaGdEUEJoanlzMldseVZ2b3J5amY5RUE5VHBLRWI0MjhSTm5rN0pt?=
 =?utf-8?B?bnQ4REV2bmhHZ2IwSHowUTFET0hpNjZwc2JiOVFKekdiOG9Eazl2dm5WTWd1?=
 =?utf-8?B?WVR3RU5uYzcyREI3RjBUczJzT2FYcFZYQ0RyU3Q1dXl6MVd5ZWNaZkUrSkcx?=
 =?utf-8?B?aVJjQ01CTkQ1bGdsZGt3cDVESEtMSkMzRnBIZlFhdENMYmtGMVZuenNhTEJN?=
 =?utf-8?B?RlZFVk1NRUJhVGJkeU9idk9YWHdSNi9hVE1oczFqWCtlTUVTdmlzMWtpUU9k?=
 =?utf-8?B?cVlVclNQdUV5TllPMFZtMjFucElOdFozeE9yb0RPN3hKY0dKSzFYZW9yb3hk?=
 =?utf-8?B?Z2F4QzEzTWdJZUcyeTdzeE4yV2M4OTFWWWhnTzZTUVNCcERJdjhqNUhGanRC?=
 =?utf-8?B?QVE3b1ZvejlpaHRCcW5qemxxSTA2M2dDcnZvTzNIRzNraHVoRDZ3UDVqMkZ3?=
 =?utf-8?B?T1A3RGpHcGY2NktPb3JsR1JTb28zc2NzdGg1blNwZWFrTHhjYW1zNzUrY2hT?=
 =?utf-8?B?aE4rdGVLWG8zSSs5Zmt6aHRoQ29PcWpWdzRtZHRpRld3V2lNdWxwRVVHTVNy?=
 =?utf-8?B?b2M1b3JRSWdsRU5aU2svakZEZ1djN3JJYXc3VDhlRVNESFptYjZuMm9YQ1Y0?=
 =?utf-8?B?UWtISnVZVFE3LzhKaXpubEtPM2VoQ2s4K05kdlBuVGI5MUpacmJ4ZmZjcWtm?=
 =?utf-8?B?d2FsYkUySjQ2Q2NuWjYxQXErWHNWbXBRb3ZHd1BJMXJlRlVZbEdnL2I5MytT?=
 =?utf-8?B?TkxrTVozY0hDUGZXRXYwQlRxMTlrRTZndzY3NTU0RzJPbG1vSmJQRGprNWY3?=
 =?utf-8?B?ZnRwZXpETlY0azg5Z1hDSTYxU0hSOFFMa01wNHA5cGdQVnhKaDMrWk5YYzZr?=
 =?utf-8?B?Rmg1ZDRVNmR2d1hRRVhKODVmSXpaNWVPaFNiT2p6MEh1ME9wNlZFU2NTdFps?=
 =?utf-8?B?V09DeHBQUTNKeklPNk81dDdjMmlvbmZOSHo3QmhLV3NiZHZxQ0hTdlZIV1BN?=
 =?utf-8?B?OCtiSkI2MUMzR09zblVQWFVzdGUyRGJwcDkzbE1sQ1dKbXR3S3ZiVnpQZ1Rn?=
 =?utf-8?B?SktUSXB3R3d3MjZRU0lPRFo3eGpDckdjT0VkMUVuWFNpaHJwUytkQ1g3MExh?=
 =?utf-8?B?Yytkcm9VTWNBZldPNTVDK0NNMlZKd3VjQzhTWGRGOXFJRk1QZ1c4YVhFbXlt?=
 =?utf-8?B?QlVFSjNkeUdNN2tDc2NObVVCaUVPRE9uaE96UEhnWkw1dzF0Qk42dXR2K1gr?=
 =?utf-8?B?T0hlaExDRk52T2VTV0ltdk9JNXpmbWxwTmRvL3VuTXUvZXdqWlhIOHpNZjFF?=
 =?utf-8?B?VXJEMEVaNFQ2OU5tVGg4VmlmSjI2SmczMGJ2S3NoUzhHY2t4YjdOL3J4ZlZ2?=
 =?utf-8?B?aWNGSmQwNmRvSEQ0a0RWSTczNXRpUEdvMDFIZ1VSWjFFOGhzc0pjMVBobTVo?=
 =?utf-8?B?bmx3K0tESkd6eFR4OWNDNjJyZGxScnhQNG9yWFhQQUFWUWd3ZjVmRGo0SzA0?=
 =?utf-8?B?OVBKRGJrZXdmdXExRmZQbm1OT3ovcGo2eHdDVUVHakE0T2EvR1dEMHlBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU9zVlJFYVRHUGZzZ1RRYzNjd1ptaSszUWFTTXB2MStFbmtid2JEY3FMZEcr?=
 =?utf-8?B?UkorK2hleUVCb0Z3djRtUnVhbXJIMDFoYnc1MkhlM241bkdubEZwajdXYnJY?=
 =?utf-8?B?YWhvMThxTjUzZzhrL3FLb2xsTG1FN1JRa3JZMFFYdmhwM3hYVERzL1VMZXA4?=
 =?utf-8?B?WFQ5Zk5hTHE0TGtnTFVDNHNFUm4vWmkwSmhnbmp5QkF3ZTFSYjRzRDJJM0gr?=
 =?utf-8?B?bndrWWpRZjBKdkxmM3Q2NE12SXk5VlBVWTdiR2NTQnhtcUJPR0RNRVhPazI3?=
 =?utf-8?B?UGk0eGZ0cjdwd2pTK3ltbWxCZHBreUlmOWFtUnZPQlFSdW5ncVVuTUI0MHo1?=
 =?utf-8?B?TFEvU0lMWnRTOEExMzNZWGY1enA3Sk1PZ1NlS2tCYk96ZXRoUXRBMGFFZjkx?=
 =?utf-8?B?dXE2Z2lwYUpkSXIrbE5uTGVtZFZUT2hoeEFKU20vSVI5czhBdmI1Nmp1RlBD?=
 =?utf-8?B?LzdCY2ZmSHlhSkFEb2g4RmozNkcvVm5qSFJCdXBqSmpZeTc2eTZYbmRCU0Rj?=
 =?utf-8?B?b05GT0lZS2pHc2hmQjc2OTVPS3R0NzB5TVFBdDNqRnhVY3I4b3JuU2NQRVlt?=
 =?utf-8?B?aUZRUUZEaGo5SlZKN2VweEJSemZ1Z05ueHhGbmMzUUlIR1RPL3lmSzBCZGFW?=
 =?utf-8?B?TGFHT2RmZkFabkJ4a1hVejBCWXFvenlDTVh5ZmJIYzRiMkppNkovMVFQa2Vw?=
 =?utf-8?B?ZGJLNEpjZ1RlN3BiYk5aa2EyNlI5NDA4eVJzVm1aNHZEM3VpL0VXNlBrNkxG?=
 =?utf-8?B?ZmdpSDRpRFBDanYwdklsKzBvWlF2a1Q1N28zS0xucHRJanhNMTlOYnZIeWFY?=
 =?utf-8?B?cFpoYzBkWVhEVkdqcFJYVlZQQS9TamEyNFZaOW9ENkpGZENjQkRFNTd1YUFr?=
 =?utf-8?B?VHc3N0thbzJzV0hUQXV5V1JIRjg2K1lvRG84RnhEbStsejg4NU9XaDVFR3JE?=
 =?utf-8?B?b2hOZUNJZ2trMHdqTTR2YldmOE9mTWROME03UnlkZk9zOERIZ2FDbGttZEh3?=
 =?utf-8?B?QlNncXkrQVlmQXZFdFJTbHNJWm1JSWRMSGVIdjlnOU5hMUdYWk1ZdUdGT3ZH?=
 =?utf-8?B?ZVdSd2lSTkxPdWtsSUh1OEdpOWIxVUx5aFAxcEhMbFplL21MMFBiWEdCMS9a?=
 =?utf-8?B?WlJkNGJmSERxYytUc04vMzVJZmlFWTh0WEQ4dlU0YjQwdzVYOFNIK3V0VWxE?=
 =?utf-8?B?NE5McjVLWFpEQ2lTRkY0WFM3c3dDQ3c2cXhFSVU0MjB4RVQzSXBjcDJoeEEr?=
 =?utf-8?B?NVBicGZIbDFiWXFVT1JZcitYaXpVYVhESkVaWlNjOVJZVkNEd2JaT09Tb0E3?=
 =?utf-8?B?dWRPZ2JPRks3NUd3RUJGSnB0QjdoSkdua2UvV2dDZFlKZUd6QnFZMHEzRDBC?=
 =?utf-8?B?aDlRRzZ5WHVvZlQ2T3lpYWhUR0FrYWg5ejg1WWF1MnR4Vmt4UERTNnNtNzhz?=
 =?utf-8?B?U25Cck1HQ3FmYmNXSmllbzUrRjcybGVOb1ltUEg5V3plMEUxOTV1WlhNWCs5?=
 =?utf-8?B?MGUySUNkSWtLa1prZlJObEJ6RUxUVXRJdFFFVDEvZnBwMEI5cGlwM0lIaUpR?=
 =?utf-8?B?bG5yVmM5dXRhb3VRQncxOTlrS1dqeHl3MnJiNjZscVowYU80VjNRWE5rYjhs?=
 =?utf-8?B?amRCR3JvYS8rQ0FLY3VDcjhscmdNQzg4Y1JkN1JGWUxwcmN2YW9URzJRWCs4?=
 =?utf-8?B?cDJsTENvell4azJKL1cvYWo4TlpQWGViTWZLZkZ2RDJ6T0pOV0ZSc0FFbTcx?=
 =?utf-8?B?QjR0K2dGMUg1VHY0eGs1c1dQNzhQbXFiVXZ5NGFKd1JDSkVlVFp6RndDTGsw?=
 =?utf-8?B?WmFXWnhscUJvQUcxc1JycmJ1ekNJSEFqaEpnSG5GMEJYM0RKTVppYkRVMVVJ?=
 =?utf-8?B?TnpOaUpDS2hWNVBObUFnTW5nK2NjMW5ZUzE1MzFMV2Jicld6TW1jRlMwejJW?=
 =?utf-8?B?WWs5bzV6T1V5YWZnK3RjY1FmV0dOUVNtNlMzTTMvNGpCelFJMEtseHJ3cDg1?=
 =?utf-8?B?elZ6bnQyUkVhVmQxN0RhVFVwQ3B0ZlQ0djZkSFltaDByVkVNK0hsRUxTaHpG?=
 =?utf-8?B?NHRJR3BscnFWRlBzTERzVW1vQkVoU25tN2diZ0NyUWF5ZEU0YUVrYVg0KzJp?=
 =?utf-8?B?eTF5MW1aaFJsSnliSThWWnAyQ3Bpd3ZnOEw4TjhmVHk2VE8wVHZoWi9EUVo5?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 30da7221-6d7b-4498-98f1-08dce96856e8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:15:52.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuxUX2rNS97fVpI4SuzEF3HjppHEluygANf7LS0AxCq+4esUsrEkeVdzMi52GFuAjKoRPht/aDlGdvxAEcz1dSwONvCG4WO6PsSMde6gOS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7881
X-OriginatorOrg: intel.com

Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> Provided that all child switch decoders are sorted by ID in ascending
> order, then it is wrong for current match_free_decoder()'s logic to
> find a free cxl decoder as explained below:
> 
> Port
>  ├── cxld A        <---->  region A
>  ├── cxld B        // no region
>  ├── cxld C        <---->  region C
> 
> Current logic will find cxld B as a free cxld, that is wrong since
> region C has not been torn down, so can not regard cxld B as free.
> 
> Fixed by finding a real free clxd by ID instead of region state.
> 
> Link: https://lore.kernel.org/all/66e08f9beb6a2_326462945d@dwillia2-xfh.jf.intel.com.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Thanks for this.

Now, on the way to recommending this I had the thought that another way
to do this would be to assume that the next decoder to allocate is
"port->commit_end + 1" and then double check that no previous decoder is
disabled.

I put that idea aside because I did not want to depend on new child
device iteration infrastructure. However, it turns out that since this
suggestion, I have found that the current behavior of
cxl_region_detach(), where it early exits upon detecting out-of-order
shutdown, leads to use after free bugs.

Part of the fix for that is introducing a new
device_for_each_child_reverse_from() helper that is identical to
device_for_each_child_reverse(), but takes a starting child device for
the iteration. With that, this allocator would not need to walk forward
through the list, it could just start at port->commit_end + 1, and then
walk backward to make sure no decoders are idle.

Let me post that fix, Cc: you, and then you can fix this allocation
order validation to use device_for_each_child_reverse_from() rather than
add more decoder_alloc tracking logic to 'struct cxl_port' since
port->commit_end is already sufficient.
