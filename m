Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042F3E485
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTj9cqDO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02791CC
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697041918; x=1728577918;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/19ygsWn7Y/nPcWEiAV4MB5PIulF5zf3Nd+QaIt82ns=;
  b=UTj9cqDOCOTyfhNuJ01Q6Xsu3cqpXKxuHRC2CeSTQccYJcVSydxsXRAZ
   5/aY2c6JEZ4hgcCkrOTyAPIWk/RzzwMjgXBIosvhUitBH/6ozy+YrlmB5
   xsp/LGmSZMS0db8sDzYYYVpxqK43rFl/+fiDEaXP/s/BrbtyRh7tJ8Pna
   vdn4EEm2LBfGcyVfKnRNMZrxxDQ/l57c6dsATmT+48L8gnVB2OEx4AEjc
   wodMCQolEqBGXMN+AA2jg4FRMkqw7RNxvePluXMtxFppYIRxF4yJq8z1L
   NLSs0kNvKUsdbDwZjyM1OQ0n1lU7dUIvpRPPh2659Oh7aEjOHEjZpap5I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369774434"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="369774434"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747518435"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="747518435"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 09:31:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 09:31:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 09:31:54 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 09:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iexLeqzUXe6QK7pX2wU+uh5Npr3c2f5M5EgMmNLcEFUDMKzfIIc74euTxMCwru52XN4Wz7jz0emiRDHMo33rQVSzv6XPcix/CbRUpXbqJLsXpnBTkDUzlbpcRx14mqbEoYQq3rLmaOX6pmX52zsvdmSfE6YlRcJ+JeqFg4vEipoiEQxRNFsO1yCg42xZX0u3lgw+LfcjCUgEzOa1BYTl/8wxxxQpmiaVsI+J2C6nvNwL7poC4EkxA9ZPowC1vc30TF8wb1N5IG57eknXsL0BZ1ki4iWyJfnJT9Fe5t4Kyh94UmCvfkt3UlLLY/zSD/0qs+pDzMPwZszIV6wKo/CN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYhqZxnfspLUOfKGdalfh10TvW5oTor7DzVtOnRvjKI=;
 b=Sr8j1FCBFYzlckhZgdZb6BUBEwLrp/bKEpwxZuXV3NwDGUAFj3tb5FlWRbDsl2YDA6VxajBXs3T5I67d9PFC9olJEa9Oj/TFVL5SXx+mjShZfPIkLHw9RDevn/5RxfFpK3XoSdET4ubPIauwgbfaLzMjg+mBZbicumaBOX2LSCwhv2KEYpmhnNh16Q+pOH3P7l00ULPqIc8D7zhbi57SOXUHGkeKFY2tSLatviJFSmFgAnkGDL7pyQ5eNUo+AykTMC2TxAhDQrUO0Cff3hL+yyCLVL7fkdIWoVg8wvznHL9B/NB0lNxfL1hiBrYJwUlb2qPwyidLQz8x62Uo+qrKsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 16:31:51 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 16:31:50 +0000
Message-ID: <33155160-b627-4d70-b7f7-0fba162183c7@intel.com>
Date: Wed, 11 Oct 2023 09:31:46 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v10 00/22] cxl: Add support for QTG ID retrieval for CXL
 subsystem
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: <linux-cxl@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Len Brown
	<lenb@kernel.org>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
 <20231011135942.0000464c@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231011135942.0000464c@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::30) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: f7909bb3-d97b-4273-e262-08dbca779216
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQX6Puq6wZS7IWiOgjlaaV5VuCwOgMgqeZuBAunbeD5K5Kd56IWhraE97uiVZqzL87xhp5gHe8LW6ysIH6bOeFTVgpZo5E/F89GrREI/bUfPl7GEVxIahXNWseXXOt7ZeGqw94mSYIHKrM7D1C0x/jmxVeBmFxOyP+J/SxR57754PddUNDGJ7q0b6wQmDVz3IVAB+h8Eaq1xlLwGF2UQwQbiTsDh3D+/nvCxgnAYYNRGVuleCSwW5k9tgCwDu1zM5/Xwcjh8PJC+J8vzWY7eJU6wRho/KeY6S2T527aozYCzk2kUUSGWHg7xBDp1DpIZxQLG1LwClE5EJ2xV4VJFU5Wdnesky+65DJ8J84i36lHNvaCs6jDj2HJh4DikGMhNiOQ72jlrNlKIFEMa7BqMorNrcDor+RISbcNd3bLpDhdm7FCBdTs65cTN0mNtRT5mWicx5oQjqhpFqbSijMPG2Pz9KrTfIYA/fd+Jw6e+QCbHMJneQH3haqADbGsi+f6ie1fQkRf805X5fNicgDP4Icj7bmEx47cCahud8IEg+0ILmUMyZfhlCOgEhv8IYSR/i8JUrB6cuOin+RO0GXBdnSOa2nNEYkRZJEiIkTl5pIqk1qfiHrPWlcbZabWm/oNL8nKJ7w0SBwPEOHNovFoZZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66556008)(31686004)(66899024)(107886003)(53546011)(6512007)(478600001)(82960400001)(86362001)(38100700002)(36756003)(31696002)(2906002)(83380400001)(8676002)(30864003)(966005)(6486002)(6666004)(2616005)(26005)(6506007)(4326008)(6916009)(8936002)(41300700001)(66476007)(54906003)(316002)(44832011)(66946007)(5660300002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1o3N2IxaHZOM2YrMnRPR2s4WVFHY3FvOHZtd1ZVc0pCK0VVbW1yZGYvL3dz?=
 =?utf-8?B?MjgydUhtMHdQQmJocXFKM2wxcWYvajgvZ2xuUUlRYXdpNmpsY1YwRTgvei8z?=
 =?utf-8?B?WGJnUkpoVjlZOEQ4K1hQaFRKRjRXbm54VGpuOGJYekNpRU4vT2xvQ3JZTlF6?=
 =?utf-8?B?T01VMTdYZERSNVNRMXN4V3A4dU5vV0FMK2FZTEFPMGJiM1NBMnZKYjB6SDNZ?=
 =?utf-8?B?WWdSN1ZWTENsYXBHcnJKVzc1eGZ2UTlMRVR4Y0pCSHJ2ZUg2L2ppc2NuVE80?=
 =?utf-8?B?RGg3dVJFTk5xRXF4andDdzVSQzJtdjZkMGxUdFI2OCtUc0Z4SG9RaThLaWo0?=
 =?utf-8?B?RDkvUEM5SFc1UlFPNXYweVlpby9yYnZrNGFKNFY0ZlhEM1NHYjZVVmY2cEYr?=
 =?utf-8?B?akNoWXZGOGo4N1BiSStYaXg4SWg1bFBQWnFJSStGdk5wTXlMKzBiZXBrUndW?=
 =?utf-8?B?NTVTZ1pXNGZrTUUwSE52SHNLR0lIbU5VZXgyZVpJd0dzSlhITWx1eFF6aWVO?=
 =?utf-8?B?c0tPRFBiTGZWUGQvMWxYVXo3c3hvT3g4MTQ5YWhpYlNWRVNhaWZ0b0ZQV1dS?=
 =?utf-8?B?ZmxNaC9FV0xlMllzYUpqcTl2dTJ4RlFaS2RiMHNKNkNIQ0pEYnZXWW52SXNi?=
 =?utf-8?B?Z3dNRWdMSmxUbi9NUXpFbitZL3RhcE04TXovc0JqUW14V0gzcndYY2lsU01D?=
 =?utf-8?B?empKeUlDRmt3SU14QXJGWk1tUGhTWkN1ZjhpT1o5M1d2Q3hLVjQwUkxYaXE0?=
 =?utf-8?B?aHpaNG85TDBlc0pBaGFCNURULzdWUU1qK3BmNDZkTHpjMnFpSzFjVmJrUENZ?=
 =?utf-8?B?UlFEZWtFeXNnWkIwLzQ5cEFNZHFwVGhxaldzL3o5MlUweEJtZGdoMXVQd3U1?=
 =?utf-8?B?VkRocGNQK3hVb002VlFGZE5KWmlyMlJjeXVoeWtwQkRRcWxjODM3d05mNXlD?=
 =?utf-8?B?R2E3RWI2Q1JDWExBY1VFbTNqTlB0QndFaVEzREN1NHJydlUrT3VJdWRnMDI5?=
 =?utf-8?B?UnRzNjN4R1l0K2Y0aXBpaHhnZFJYczZxRjcreGMweUJQNmJKSERGa25LWitQ?=
 =?utf-8?B?OEtxUWhzeXlpTityRVk5eGE2M3VnTHlJSlJlc2dGc2puMVhDcFpGMWpVai9r?=
 =?utf-8?B?N25uS1JNa3lsSjFaMlVQRWpBUGZoSHp0K0dUZDlFRTRNRDBvU0Nxa2RneGsw?=
 =?utf-8?B?Y2hCbVpuT2FsUllXV2FhbjNqRnI5K0hKSUV0MFdCMTEvSXdXN3cxVVMwWlJw?=
 =?utf-8?B?dmt3a0hqN1A2c1l0bFVQQXhRNHhCM0xIUWVJeEY2aitTRWEyWERqRU51ckNB?=
 =?utf-8?B?Uk9sWGdXRlRPL3Bvcm1zK1czdUVIby9YUXpyamNNK1g4bk05bUxHZ3daazgr?=
 =?utf-8?B?VGdtNHhXSmc4R2JIZTlLUng4ckZ0aTVDbUJoUXd1SitBS3c4RGx4WkhHdVpH?=
 =?utf-8?B?WGt3RTVSZTY4Ri9GNjRPUFJwOEt4aGMrU0J6aWZUR1JCZ3lWeDh3TnQ3WlNq?=
 =?utf-8?B?Ynl4WlErUWF5VnpvaHc4WVRIaWFaVnp0b1V5V09seE5qbXgwRlVsVGkxalM3?=
 =?utf-8?B?V2d5aVhMSjVhRDdNN3pETThwaGJYTS9VOFZJL0t5dURISEhhcHErcVd1VmVp?=
 =?utf-8?B?RE9MbTd6bG4xaFBOMTRHMUlJcXlDcHdTWGM1eW91OVJneExTTWZFK202amhJ?=
 =?utf-8?B?UG9zTHZ5R0NmNnhseG9vUUUxdHRZSkJPVmtxY3I1RVpSYkFZa3kvSjZJRG5v?=
 =?utf-8?B?N1pJQk9nVHE0UW44amNDSElpZjlrRHZSWFNJeVNTU0tuNE9iNDZDbkJzRjll?=
 =?utf-8?B?WDU0VnRCekd0QUZlSEpHRmd0eXcrWm0ra2hqUlBWSkpUK3NQaE0wWEpvRnM2?=
 =?utf-8?B?ZThZUjFMeGIrRmZGcjhCZXgvOHo1cXNYVkMvTm1aNnlPd2ZjK2xHTVJrRllX?=
 =?utf-8?B?NXhUa3k5KzMxYmpQUUNpRDFmRWVJMlBrRHRtYmxSUzhnWDZRRUtBc3RqNDQ4?=
 =?utf-8?B?Wnpvb1c1Zk9RamtlQmN5Y0M2REdrMkNmSDJTNFNtdWVpZFBxR1drT0JMT21T?=
 =?utf-8?B?RzVzNkdHaUlrVG1mOXNtNnE4NHlHZ1U5c2lxZFF2Vjcyd2NjRUFkLzRTdUlq?=
 =?utf-8?Q?w2REpEWME68dC7RDrPDNN7Fmf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7909bb3-d97b-4273-e262-08dbca779216
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 16:31:50.5784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP4VpRnLzwWnAXxXVrPYFAC+gCE6qHnps987lRJxb4YSbqFTc0bzpRsgnN+WqAJOJOhG5NCd/DffcfmNkRFpKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/23 05:59, Jonathan Cameron wrote:
> On Tue, 10 Oct 2023 18:04:56 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> Awkward to rename a patch series, but feels like the QTG ID part may be the last thing
> added but there is a whole bunch of stuff in between to enable that which
> isn't covered by the one line description.

Yes... casualty of recombining everything minus things that are upstreamed already after having the series split. Just wanted to keep everything together so it's convenient for Dan's merging. Most of the changes should be the last few patches.
 
> 
> J
> 
>> v10:
>> - Remove memory allocation in DSM handler. Add input parameters to request number of ids
>>   to return. (Dan)
>> - Only export a single qos_class sysfs attribute, qos_class0 for devices. (Dan)
>> - Add sanity check of device qos_class against root decoders (Dan)
>> - Recombine all relevant patches for cxl upstream merge
>> - Rebased against v6.6-rc4
>>
>> v9:
>> - Correct DSM input package to use integers. (Dan)
>> - Remove all endien conversions. (Dan)
>>
>> v8:
>> - Correct DSM return package parsing to use integers
>>
>> v7:
>> - Minor changes. Please see specific patches for log entries addressing comments
>>   from v6.
>>
>> v6:
>> - Please see specific patches for log entries addressing comments from v5.
>> - Use CDAT sub-table structs as is, adjust w/o common header. Changing causes
>>   significant ACPICA code changes.
>> - Deal with table header now that is a union. (Jonathan)
>> - Move DSMAS list destroy to core/cdat.c. (Jonathan)
>> - Retain and display entire QTG ID list from _DSM. (Jonathan)
>>
>> v5:
>> - Please see specific patches for log entries addressing comments from v4.
>> - Split out ACPI and generic node code to send separately to respective maintainers
>> - Reworked to use ACPI tables code for CDAT parsing (Dan)
>> - Cache relevant perf data under dports (Dan)
>> - Add cxl root callback for QTG ID _DSM (Dan)
>> - Rename 'node_hmem_attr' to 'access_coordinate' (Dan)
>> - Change qtg_id sysfs attrib to qos_class (Dan)
>>
>> v4:
>> - Reworked PCIe link path latency calculation
>> - 0-day fixes
>> - Removed unused qos_list from cxl_memdev and its stray usages
>>
>> v3:
>> - Please see specific patches for log entries addressing comments from v2.
>> - Refactor cxl_port_probe() additions. (Alison)
>> - Convert to use 'struct node_hmem_attrs'
>> - Refactor to use common code for genport target allocation.
>> - Add third array entry for target hmem_attrs to store genport locality data.
>> - Go back to per partition QTG ID. (Dan)
>>
>> v2:
>> - Please see specific patches for log entries addressing comments from v1.
>> - Removed ACPICA code usages.
>> - Removed PCI subsystem helpers for latency and bandwidth.
>> - Add CXL switch CDAT parsing support (SSLBIS)
>> - Add generic port SRAT+HMAT support (ACPI)
>> - Export a single QTG ID via sysfs per memory device (Dan)
>> - Provide rest of DSMAS range info in debugfs (Dan)
>>
>> Hi Dan,
>> Please consider taking the entire series including the CXL bits for the next
>> convenient merge window. Thanks!
>>
>> This series adds the retrieval of QoS Throttling Group (QTG) IDs for the CXL Fixed
>> Memory Window Structure (CFMWS) and the CXL memory device. It provides the QTG IDs
>> to user space to provide some guidance with putting the proper DPA range under the
>> appropriate CFMWS window for a hot-plugged CXL memory device.
>>
>> The CFMWS structure contains a QTG ID that is associated with the memory window that the
>> structure exports. On Linux, the CFMWS is represented as a CXL root decoder. The QTG
>> ID will be attached to the CXL root decoder and exported as a sysfs attribute (qos_class).
>>
>> The QTG IDs for a device is retrieved via sending a _DSM method to the ACPI0017 device.
>> The _DSM expects an input package of 4 DWORDS that contains the read latency, write
>> latency, read bandwidth, and write banwidth. These are the caluclated numbers for the
>> path between the CXL device and the CPU. The list of QTG IDs are also exported as a sysfs
>> attribute under the mem device memory partition type:
>> /sys/bus/cxl/devices/memX/ram/qos_class
>> /sys/bus/cxl/devices/memX/pmem/qos_class
>> A mapping of DPA ranges and it's correlated QTG IDs are found under
>> /sys/kernel/debug/cxl/memX/qtgmap. Each DSMAS from the device CDAT will provide a DPA
>> range.
>>
>> The latency numbers are the aggregated latencies for the path between the CXL device and
>> the CPU. If a CXL device is directly attached to the CXL HB, the latency
>> would be the aggregated latencies from the device Coherent Device Attribute Table (CDAT),
>> the caluclated PCIe link latency between the device and the HB, and the generic port data
>> from ACPI SRAT+HMAT. The bandwidth in this configuration would be the minimum between the
>> CDAT bandwidth number, link bandwidth between the device and the HB, and the bandwidth data
>> from the generic port data via ACPI SRAT+HMAT.
>>
>> If a configuration has a switch in between then the latency would be the aggregated
>> latencies from the device CDAT, the link latency between device and switch, the
>> latency from the switch CDAT, the link latency between switch and the HB, and the
>> generic port latency between the CPU and the CXL HB. The bandwidth calculation would be the
>> min of device CDAT bandwidth, link bandwith between device and switch, switch CDAT
>> bandwidth, the link bandwidth between switch and HB, and the generic port bandwidth
>>
>> There can be 0 or more switches between the CXL device and the CXL HB. There are detailed
>> examples on calculating bandwidth and latency in the CXL Memory Device Software Guide [4].
>>
>> The CDAT provides Device Scoped Memory Affinity Structures (DSMAS) that contains the
>> Device Physical Address (DPA) range and the related Device Scoped Latency and Bandwidth
>> Informat Stuctures (DSLBIS). Each DSLBIS provides a latency or bandwidth entry that is
>> tied to a DSMAS entry via a per DSMAS unique DSMAD handle.
>>
>> Test setup is done with runqemu genport support branch [6]. The setup provides 2 CXL HBs
>> with one HB having a CXL switch underneath. It also provides generic port support detailed
>> below.
>>
>> A hacked up qemu branch is used to support generic port SRAT and HMAT [7].
>>
>> To create the appropriate HMAT entries for generic port, the following qemu paramters must
>> be added:
>>
>> -object genport,id=$X -numa node,genport=genport$X,nodeid=$Y,initiator=$Z
>> -numa hmat-lb,initiator=$Z,target=$X,hierarchy=memory,data-type=access-latency,latency=$latency
>> -numa hmat-lb,initiator=$Z,target=$X,hierarchy=memory,data-type=access-bandwidth,bandwidth=$bandwidthM
>> for ((i = 0; i < total_nodes; i++)); do
>> 	for ((j = 0; j < cxl_hbs; j++ )); do	# 2 CXL HBs
>> 		-numa dist,src=$i,dst=$X,val=$dist
>> 	done
>> done
>>
>> See the genport run_qemu branch for full details.
>>
>> [1]: https://www.computeexpresslink.org/download-the-specification
>> [2]: https://uefi.org/sites/default/files/resources/Coherent%20Device%20Attribute%20Table_1.01.pdf
>> [3]: https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf
>> [4]: https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device%20SW%20Guide_Rev1p0.pdf
>> [5]: https://lore.kernel.org/linux-cxl/20230313195530.GA1532686@bhelgaas/T/#t
>> [6]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=cxl-qtg
>> [7]: https://github.com/pmem/run_qemu/tree/djiang/genport
>> [8]: https://github.com/davejiang/qemu/tree/genport
>>
>> ---
>>
>> base-commit: 178e1ea6a68f12967ee0e9afc4d79a2939acd43c
>>
>> ---
>> Dave Jiang (22):
>>       cxl: Export QTG ids from CFMWS to sysfs as qos_class attribute
>>       cxl: Add checksum verification to CDAT from CXL
>>       cxl: Add support for reading CXL switch CDAT table
>>       acpi: Move common tables helper functions to common lib
>>       lib/firmware_table: tables: Add CDAT table parsing support
>>       base/node / acpi: Change 'node_hmem_attrs' to 'access_coordinates'
>>       acpi: numa: Create enum for memory_target access coordinates indexing
>>       acpi: numa: Add genport target allocation to the HMAT parsing
>>       acpi: Break out nesting for hmat_parse_locality()
>>       acpi: numa: Add setting of generic port system locality attributes
>>       acpi: numa: Add helper function to retrieve the performance attributes
>>       cxl: Add callback to parse the DSMAS subtables from CDAT
>>       cxl: Add callback to parse the DSLBIS subtable from CDAT
>>       cxl: Add callback to parse the SSLBIS subtable from CDAT
>>       cxl: Add support for _DSM Function for retrieving QTG ID
>>       cxl: Calculate and store PCI link latency for the downstream ports
>>       cxl: Store the access coordinates for the generic ports
>>       cxl: Add helper function that calculate performance data for downstream ports
>>       cxl: Compute the entire CXL path latency and bandwidth data
>>       cxl: Store QTG IDs and related info to the CXL memory device context
>>       cxl: Export sysfs attributes for memory device QoS class
>>       cxl: Check qos_class validity on memdev probe
>>
>>
>>  Documentation/ABI/testing/sysfs-bus-cxl |  49 +++++
>>  MAINTAINERS                             |   2 +
>>  drivers/acpi/Kconfig                    |   1 +
>>  drivers/acpi/numa/hmat.c                | 172 +++++++++++++---
>>  drivers/acpi/tables.c                   | 178 +----------------
>>  drivers/base/node.c                     |  12 +-
>>  drivers/cxl/Kconfig                     |   1 +
>>  drivers/cxl/acpi.c                      | 151 +++++++++++++-
>>  drivers/cxl/core/Makefile               |   1 +
>>  drivers/cxl/core/cdat.c                 | 249 ++++++++++++++++++++++++
>>  drivers/cxl/core/mbox.c                 |   1 +
>>  drivers/cxl/core/memdev.c               |  34 ++++
>>  drivers/cxl/core/pci.c                  | 125 ++++++++++--
>>  drivers/cxl/core/port.c                 | 124 +++++++++++-
>>  drivers/cxl/cxl.h                       |  74 +++++++
>>  drivers/cxl/cxlmem.h                    |  23 +++
>>  drivers/cxl/cxlpci.h                    |  15 ++
>>  drivers/cxl/mem.c                       |  68 +++++++
>>  drivers/cxl/port.c                      | 109 +++++++++++
>>  include/linux/acpi.h                    |  54 +++--
>>  include/linux/fw_table.h                |  52 +++++
>>  include/linux/node.h                    |   8 +-
>>  lib/Kconfig                             |   3 +
>>  lib/Makefile                            |   2 +
>>  lib/fw_table.c                          | 237 ++++++++++++++++++++++
>>  25 files changed, 1478 insertions(+), 267 deletions(-)
>>  create mode 100644 drivers/cxl/core/cdat.c
>>  create mode 100644 include/linux/fw_table.h
>>  create mode 100644 lib/fw_table.c
>>
>> --
>>
>>
> 
> 
