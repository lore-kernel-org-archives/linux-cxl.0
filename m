Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15EEEB64D9
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Jun 2023 18:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjF0SUg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjF0SUe (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Jun 2023 14:20:34 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2054.outbound.protection.outlook.com [40.92.53.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906359C
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jun 2023 11:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4vW1T/hiqDIsuV8MeqNKq60hwjCnTD8xclnn3SDJ1NghZG/7n3/Im7PDry031NXwqgl3TxHoOBejAUAbMTT1WDb6JJ2fco9LxhJM2+c6CuX8N85cdkIhDEVXEbrNEAA+KeVIQ+9KVZYLp6//V4JTM97uBZYqRrVpanT95IzBjfT1nrONN0Nzk7RbalHrO2IsLSb9RC3XXv0LQbcA5u3AX8wc9XvgHC8Ixsn1GFHbgUhaV6T+mWWTnzQspyvIeUH3tjIkim1jzk/24M+L7XupRFcarrkuTv0TBZ2k/v1tlwyLIdUouTpndeCTbr0sBqJMzNmYFfFqqbQg0Vwdp1y8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeezxg6kbJCAmlxjFdOxWchm1cY4e9wSDZAYPTD+ECQ=;
 b=c794FHbFcuHQRs2J3h2PCWqXW6t7fEWSv7k9Angex1o+ry8H4l52jfkORdJh+D6+RachS2I1bzyJwr4wbRPSQE+GzIG7+N31a8er3ykGqulTtE1OcFyJL89TpxUeTOMewCih/fJr+Y8zV95lfkumdMqpESYYzE/4hL7UnrRyS7LOF42rjbcqMsYDdqyhi/nAZnXXHSb+HYFM98P8PilRixScdVLmhcwhm8Mr3sTlpk1AU/B4n5yd9JNPf10lFk34L8EyLEuofKJa5TvZiCcDiZ7Pv+53WWBxy4TGXL+OKNa8LLCkbC1s8rTca/jw8OUGL2VlGAau91LBibnnH/RESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeezxg6kbJCAmlxjFdOxWchm1cY4e9wSDZAYPTD+ECQ=;
 b=QSjniE6Qw4omG20WNnMnLjJ61r05vMBC+aXpzQT/6Lu6lNK8393xZ2LKnJ/Efy1ZI2arK6etSY0nFJJgv56S5+WGGIF0yIFdrJ4JNc2tvdSizwAVZ7CXkfKlhD5tX+Ks+0OFrRbigYwphabFnE7tUrvrjqx0mkE81ruJGcrMcB4SOmbe0MQIW00fJvf51rE7SAk1kFtjLR5JtCpCdm+ewRl6aaS1ZPQUZNfprXi6H0M4XrLJMU8JPNoCo8Rr8GV8zib/M3leO/U83SmtxJR4RoOLvWh+SCjFZkMaHaLGcyEEnrL2Tu/3nf7nAL4xYseWsKi1rcD4AMpFoSGXfJ837w==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR06MB6178.apcprd06.prod.outlook.com (2603:1096:820:d8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Tue, 27 Jun 2023 18:20:25 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 18:20:24 +0000
Date:   Tue, 27 Jun 2023 11:20:02 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com
Subject: Re: [PATCH 4/5] cxl/mem: Add support to handle DCD add and release
 capacity events.
Message-ID: <SG2PR06MB33977525B124269A5E6AB9F6B227A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
 <ZIp1TSeHUElgSunG@aschofie-mobl2>
 <648be0e5de7a9_1c7ab429469@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <648be0e5de7a9_1c7ab429469@iweiny-mobl.notmuch>
X-TMN:  [OSA/BaYCbgL4IB1C9OxwWjC45fu/n+zN03SP0/VPMI6kCHQCFDKnu5TKAhFNUY7XnFFXW8Akxew=]
X-ClientProxiedBy: BYAPR07CA0062.namprd07.prod.outlook.com
 (2603:10b6:a03:60::39) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZJsoUpAbhcXPV8pN@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR06MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c915679-4283-47cb-8bd0-08db773b2c88
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnpGrp2Kpt1LRB/0F8qA1SPF5Oc1pvchRGWe+3z3ek8TAouRflXYy5/6hLH7mLevR96RSYeCD3iTWBpAroJTmU9xa1LN39OGdj9eXeMaLcmaDsWpKiqLOaEN2BQcb14bcgV+/IBV+oql+6F70WHlAchUpKTldaEeBrkz/hEaXsDXjpDvqAuuWwS0mrEIpDaFjgTp8/thlev6+lC1e+sG4LPFbmYXUFLWwXU71iuES0xGVBm2hYWZx3ifMW1UiRDnmCzjCeJPA+Dewgse9KjfqPvlcJjFlYyjQWAxDo9wgEtcpx01XCjuoX1HsAkYqru2rqRqFfQTXLV2A7m7nhKAlOcrA2Lrs7ue+nNMVVtDZVnKmljTs8IdoduEI7Hq8/bANimwt1LKrjHS/nZYOsegdFdMwevYY0rcmxM8utAaBmkH4rAdd0C/uwFIDYMSHOR2NDxDdrUyXOmpARXRkAoXY92Vxsf/tuCTTuaNYX9hauGIUdVveXAKu/Tbgzer6lvPdLv801TmHhcGtHIg4FKT2rDj0Dm7SYcSYw0WKCR6XMENPTGCgo/H/pbdzcgnp70FaPLiAmBn6o+NNNM9cbuW8Ln+9iwEsdeVFGusvnvFtT6V94ncpOr6Lw8+sYlVzy9Vbj9U8amtcEguw3Jz5o5Mh6/6Ou16uVmVc/kg6wObWIn+jut14OpCJpB8NNmDoeJBwN5z01EsRUt9G+aKGvHvXF1cUW80rJ2ycLV4m2XETFNdBRcX7WndWow4BqJqiCi6+Wk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zg4o+vy/iWGrOzvkyyzfmTEo4Nrou+aB2yyieCh2tgOJi8B3EQZ/urN/8JpCXO+foPmtIGbeX51GPyAcpEQzqP3D39NkTtNLmqbh0RjPBmaggQS1aM4cOouPwi7YaFMPNyAhs/8rqakifyw0NdruWhq08VIUeV6r/B6UsMd60I6YxBxT5gqS9ZUQ2cHIXM5/q+Qdh1pf6jDxIdfJpxNL0n0ZjCkBD/WP8SuR6xwOmZ+p2uOwLIwCTjaChQIIoLAF2j9TSor6AfhajT7HqL5sekskbIbWVHXyTviqcJBhFYduaxzj2780LEiKjtmFm8yXYoH6oJOTU+t+eVGYi4fXrd730Ce3TlNVVKvpXWKqPiPYtxhxlmVIWSqCzubLvYv4czCV50mWVtsyjEBm7urR1JbzkGhi++d/3pW6ldgPso/70mvoFAakI3+df3dj6ADaoV36YBL+Fwgctorxsc/LCPM7IcG9eDWQ5OYy8l/E2S2y5OP4DFzFqgZZO8CWLXj3nPNNQOOYJE/xh0z41m6wg8Eytb00N7qdxH4Jm27thn36Me2Xe61yH8DTtUC0xfcsHGVIRvfr8G6dZTmJDlkm9LF5b4h2ltjIK3Qu7XwZTyUma+LUqprQphwIwaA2L0P+
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUJEbGtoUlk5ZGFlT2dRdnhQQ2JiMEh6OTlvdVczei96bk12TFRTMHYydjYw?=
 =?utf-8?B?aWxJd3dzV2Rmc3NKOE9LUGs1SG9hTmFwams1SjNFUWV0a3hkcDIzRzF6RWoz?=
 =?utf-8?B?YTZVZ0g5YUNlRTNmQXE3MG95Vm5BcW02YW1RV3hRNFBpWlZNMDdoYUxCWTBq?=
 =?utf-8?B?cmFnS2pjeWw1c01VWDVBMUtONnQxZTBwZWx5a2huTFdVejQ1cTQzdW9vbFdk?=
 =?utf-8?B?eG9iQUVINC8vYUxQMU5yT0p2aFplVEltWHYwUXJkazRMZjdKUVVjSWN2Q0Ji?=
 =?utf-8?B?YnVERjZLYkpkcFR3Y3B3WTZCZEc2NnRQSXRYbk9XT3NrYSs3ckJYR3RLUm0r?=
 =?utf-8?B?SXo4SVZkUjRUWnlsTG9HTkgycHE1ZlQwb1dEdC9leldqNUQvdzRXczNmdVlD?=
 =?utf-8?B?cGFuRFdaWkc5VE1nMmtlVm9WQ0VNZnBTK3hROUROVjAvVEd6dnF3RUdGQzRE?=
 =?utf-8?B?ek56M051M1ppUFgrLzd4cU9jOFQ4c2VrVXZCKzNrY3hPWFRkTTZETzErNlZj?=
 =?utf-8?B?aGY3S3draVMrb3gydmZGTnZEL2pHWG9aQThpNDRCcnFwSUNhRHFBcTMwNnF6?=
 =?utf-8?B?TG9zOVRqaDFIeUtLYzAxV1RxZ1lYVXNOajNuMFc5cmRJY2JQUDByTmtqemFt?=
 =?utf-8?B?VCsvMlpDVTFOWXRWTWh0OTloVDVqNGE4NTFESWlIL2h6MXFkK01PL21hWi90?=
 =?utf-8?B?dlJGQk13SWJwcWpmZTViOGszbktITEpRUytJUzEweXczUXloMzl1VkVsWkxh?=
 =?utf-8?B?YndkVkVoMHR4RXMvZ2hSY2VXZ0FzRGRiZkZsUC9Wa04wdWtGMDFJT3dQaGs3?=
 =?utf-8?B?c0hOY1hteEtoc0dLRk83aHJTaXA3V21VSlJaUlpDT2hDOW52QVJlT1Z0WEwy?=
 =?utf-8?B?b2Z2dXh2RHVPYkVyM3E5RElCbmN4RTFTUE5ycTc3eTNINmFRajhUQUQvVkpa?=
 =?utf-8?B?aXpEbHVzWG9Pb0dkUXpBNTlnRHdGSmRSMytGRlBUMGVhSkg3SVZRdWhJRlhY?=
 =?utf-8?B?ZkZDTDRURE14YzJhbm4wYkg5S2pSckJqL3p3cER2b3J4bjZpSXlaMytOY1BI?=
 =?utf-8?B?ZW9OUVU1L280bmdpTXJnNzk0c0phVkdSMmNHYlBHUFpoZ2VSU1hhWWp1bzZS?=
 =?utf-8?B?T3VmOEJvRUM2ejRWejJ1RVJRazBqeFlxWnBXeWxOT3JmNmlRdDdpeUZQUnRa?=
 =?utf-8?B?OUFOMzBneDd0V2hLeG9yOXZORDlaa1daOE83aUdIMk5kYVhoSkNuSjJ3VHUv?=
 =?utf-8?B?WitZNjVIdDEvNUJHUHIrc2NaN2gxS0k2RFBtQ3o4SXVPYlphdGFoUlhnUUw3?=
 =?utf-8?B?VEFialhMQ1NJeW1sbFpIdzRIRVJZRTZwN2J2VVljc3ByNDVlclhjT0xwbWRW?=
 =?utf-8?B?a0xNTlQxZUdnQ28waEhubzdFSzI1Umgyb0pNak1ScEszVFhnV09xK1NrZDM3?=
 =?utf-8?B?TTZNd2t3akFsbnV4MEdzUTJYSG9leG5rU1NKc1hJVVVBK3NsUkFBa2lLdG9i?=
 =?utf-8?B?R2JNODJkSHBrb2I0V1FCVFU2OEFmNWViODh4QW5uQUNhUEpUallhYnhkS0VB?=
 =?utf-8?B?YnljWjJ6UmJWQXhTTFJWVXkvcDF5Wk1odmcvNmNLT3pqQlNXV3lYV3BDMWhD?=
 =?utf-8?B?WlVQcVlITXdSbTZxV1pUU0dBRDZTK21Qdys0SGdqeE5SRDl0c3lXN1BkUFkz?=
 =?utf-8?B?K2dJa01sVmVsQ3VoUUJkMmpMMWU1WFZSMjBWbVcycFVxL08zeExLRHpBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c915679-4283-47cb-8bd0-08db773b2c88
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 18:20:24.9294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6178
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 06/15/2023 21:11, Ira Weiny wrote:
> Alison Schofield wrote:
> > On Wed, Jun 14, 2023 at 12:16:31PM -0700, Ira Weiny wrote:
> > > From: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > A dynamic capacity device utilizes events to signal the host about the
> > > changes to the allocation of DC blocks. The device communicates the
> > > state of these blocks of dynamic capacity through an extent list that
> > > describes the starting DPA and length of all blocks the host can access.
> > > 
> > > Based on the dynamic capacity add or release event type,
> > > dynamic memory represented by the extents are either added
> > > or removed as devdax device.
> > 
> > Nice commit msg, please align second paragraph w first.
> 
> ok... fixed.  :-)
> 
> > 
> > > 
> > > Process the dynamic capacity add and release events.
> > > 
> > > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > > 
> > > ---
> > > [iweiny: Remove invalid comment]
> > > ---
> > >  drivers/cxl/core/mbox.c   | 345 +++++++++++++++++++++++++++++++++++++++++++++-
> > >  drivers/cxl/core/region.c | 214 +++++++++++++++++++++++++++-
> > >  drivers/cxl/core/trace.h  |   3 +-
> > >  drivers/cxl/cxl.h         |   4 +-
> > >  drivers/cxl/cxlmem.h      |  76 ++++++++++
> > >  drivers/cxl/pci.c         |  10 +-
> > >  drivers/dax/bus.c         |  11 +-
> > >  drivers/dax/bus.h         |   5 +-
> > >  8 files changed, 652 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index c5b696737c87..db9295216de5 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -767,6 +767,14 @@ static const uuid_t log_uuid[] = {
> > >  	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
> > >  };
> > >  
> > > +/* See CXL 3.0 8.2.9.2.1.5 */
> > > +enum dc_event {
> > > +	ADD_CAPACITY,
> > > +	RELEASE_CAPACITY,
> > > +	FORCED_CAPACITY_RELEASE,
> > > +	REGION_CONFIGURATION_UPDATED,
> > > +};
> > > +
> > >  /**
> > >   * cxl_enumerate_cmds() - Enumerate commands for a device.
> > >   * @mds: The driver data for the operation
> > > @@ -852,6 +860,14 @@ static const uuid_t mem_mod_event_uuid =
> > >  	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
> > >  		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
> > >  
> > > +/*
> > > + * Dynamic Capacity Event Record
> > > + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> > > + */
> > > +static const uuid_t dc_event_uuid =
> > > +	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c,
> > > +		0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a);
> > > +
> > >  static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> > >  				   enum cxl_event_log_type type,
> > >  				   struct cxl_event_record_raw *record)
> > > @@ -945,6 +961,188 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> > >  	return rc;
> > >  }
> > >  
> > > +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> > > +				struct cxl_mbox_dc_response *res,
> > > +				int extent_cnt, int opcode)
> > > +{
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	int rc, size;
> > > +
> > > +	size = struct_size(res, extent_list, extent_cnt);
> > > +	res->extent_list_size = cpu_to_le32(extent_cnt);
> > > +
> > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = opcode,
> > > +		.size_in = size,
> > > +		.payload_in = res,
> > > +	};
> > > +
> > > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > > +
> > > +	return rc;
> > > +
> > > +}
> > > +
> > > +static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
> > > +					int *n, struct range *extent)
> > > +{
> > > +	struct cxl_mbox_dc_response *dc_res;
> > > +	unsigned int size;
> > > +
> > > +	if (!extent)
> > > +		size = struct_size(dc_res, extent_list, 0);
> > > +	else
> > > +		size = struct_size(dc_res, extent_list, *n + 1);
> > > +
> > > +	dc_res = krealloc(*res, size, GFP_KERNEL);
> > > +	if (!dc_res)
> > > +		return -ENOMEM;
> > > +
> > > +	if (extent) {
> > > +		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
> > > +		memset(dc_res->extent_list[*n].reserved, 0, 8);
> > > +		dc_res->extent_list[*n].length = 
> > > +				cpu_to_le64(range_len(extent));
> > 
> > Unnecessary return. I think that fits in 80 columns.
> 
> exactly 80...  fixed.
> 
> > 
> > > +		(*n)++;
> > > +	}
> > > +
> > > +	*res = dc_res;
> > > +	return 0;
> > > +}
> > > +/**
> > > + * cxl_handle_dcd_event_records() - Read DCD event records.
> > > + * @mds: The memory device state
> > > + *
> > > + * Returns 0 if enumerate completed successfully.
> > > + *
> > > + * CXL devices can generate DCD events to add or remove extents in the list.
> > > + */
> > 
> > That's a kernel doc comment, so maybe can be clearer.
> 
> Or remove the kernel doc comment.
> 
> > It's called 'handle', so 'Read DCD event records' seems like a mismatch.
> 
> Yea.
> 
> > Probably needs more explaining.
> 
> Rather I would say less.  How about simply:
> 
> /* Returns 0 if the event was handled successfully. */
> 
> Or even nothing at all.  It is a static function and used 1 place.  Not
> sure we even need that line.
> 
> > 
> > 
> > > +static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
> > > +					struct cxl_event_record_raw *rec)
> > > +{
> > > +	struct cxl_mbox_dc_response *dc_res = NULL;
> > > +	struct device *dev = mds->cxlds.dev;
> > > +	uuid_t *id = &rec->hdr.id;
> > > +	struct dcd_event_dyn_cap *record =
> > > +			(struct dcd_event_dyn_cap *)rec;
> > > +	int extent_cnt = 0, rc = 0;
> > > +	struct cxl_dc_extent_data *extent;
> > > +	struct range alloc_range, rel_range;
> > > +	resource_size_t dpa, size;
> > > +
> > 
> > Please reverse x-tree. And if things like that *record can't fit within
> > 80 columns and in reverse x-tree order, then assign it afterwards.
> 
> Done.
> 
> > 
> > 
> > > +	if (!uuid_equal(id, &dc_event_uuid))
> > > +		return -EINVAL;
> > > +
> > > +	switch (record->data.event_type) {
> > 
> > Maybe a local for record->data.extent that is used repeatedly below,
> > or,
> > Perhaps pull the length and dpa local defines you made down in the
> > RELEASE_CAPACITY up here and share them with ADD_CAPACITY. That'll
> > reduce the le65_to_cpu noise. Add similar for shared_extn_seq.
> 
> I'm thinking ADD_CAPACITY and RELEASE_CAPACITY need to be 2 separate
> functions which make this function a simple uuid check and event_type
> switch.
> 
> Having local variables for those become much cleaner then.
> 
> I think the handling of dc_res would be cleaner then too.
> 
> > 
> > 
> > > +	case ADD_CAPACITY:
> > > +		extent = devm_kzalloc(dev, sizeof(*extent), GFP_ATOMIC);
> > > +		if (!extent)
> > > +			return -ENOMEM;
> > > +
> > > +		extent->dpa_start = le64_to_cpu(record->data.extent.start_dpa);
> > > +		extent->length = le64_to_cpu(record->data.extent.length);
> > > +		memcpy(extent->tag, record->data.extent.tag,
> > > +				sizeof(record->data.extent.tag));
> > > +		extent->shared_extent_seq =
> > > +			le16_to_cpu(record->data.extent.shared_extn_seq);
> > > +		dev_dbg(dev, "Add DC extent DPA:0x%llx LEN:%llx\n",
> > > +					extent->dpa_start, extent->length);
> > > +		alloc_range = (struct range) {
> > > +			.start = extent->dpa_start,
> > > +			.end = extent->dpa_start + extent->length - 1,
> > > +		};
> > > +
> > > +		rc = cxl_add_dc_extent(mds, &alloc_range);
> > > +		if (rc < 0) {
> > 
> > How about 
> > 		if (rc >=)
> > 			goto insert;
> > 
> > Then you can remove this level of indent.
> 
> I think if this is a separate function it will be better...
> 
> Also this entire indent block could be another sub function because AFAICS
> (see below) it always returns out from this block (only via the 'out'
> label in 1 case which seems redundant).
> 
> > 
> > > +			dev_dbg(dev, "unconsumed DC extent DPA:0x%llx LEN:%llx\n",
> > > +					extent->dpa_start, extent->length);
> > > +			rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, NULL);
> > > +			if (rc < 0) {
> > > +				dev_err(dev, "Couldn't create extent list %d\n",
> > > +									rc);
> > > +				devm_kfree(dev, extent);
> > > +				return rc;
> > > +			}
> > > +
> > > +			rc = cxl_send_dc_cap_response(mds, dc_res,
> > > +					extent_cnt, CXL_MBOX_OP_ADD_DC_RESPONSE);
> > > +			if (rc < 0) {
> > > +				devm_kfree(dev, extent);
> > > +				goto out;
> 
> This if is not doing anything useful.  Because this statement ...
> 
> > > +			}
> > > +
> > > +			kfree(dc_res);
> > > +			devm_kfree(dev, extent);
> 
> ...  and the 'else' here end up being the same logic.  The 'out' label
> flows through kfree(dc_res).  Is the intent that
> cxl_send_dc_cap_response() has no failure consequences?
> 
> > > +
> > > +			return 0;
> > > +		}
> > 
> > insert:
> > 
> > > +
> > > +		rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
> > > +				GFP_KERNEL);
> > > +		if (rc < 0)
> > > +			goto out;
> > > +
> > > +		mds->num_dc_extents++;
> > > +		rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &alloc_range);
> > > +		if (rc < 0) {
> > > +			dev_err(dev, "Couldn't create extent list %d\n", rc);
> > > +			return rc;
> > > +		}
> > > +
> > > +		rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
> > > +					      CXL_MBOX_OP_ADD_DC_RESPONSE);
> > > +		if (rc < 0)
> > > +			goto out;
> > > +
> > > +		break;
> > > +
> > > +	case RELEASE_CAPACITY:
> > > +		dpa = le64_to_cpu(record->data.extent.start_dpa);
> > > +		size = le64_to_cpu(record->data.extent.length);
> > 
> > ^^ do these sooner and share
> 
> I think add/release should be their own functions.
> 
> > 
> > > +		dev_dbg(dev, "Release DC extents DPA:0x%llx LEN:%llx\n",
> > > +				dpa, size);
> > > +		extent = xa_load(&mds->dc_extent_list, dpa);
> > > +		if (!extent) {
> > > +			dev_err(dev, "No extent found with DPA:0x%llx\n", dpa);
> > > +			return -EINVAL;
> > > +		}
> > > +
> > > +		rel_range = (struct range) {
> > > +			.start = dpa,
> > > +			.end = dpa + size - 1,
> > > +		};
> > > +
> > > +		rc = cxl_release_dc_extent(mds, &rel_range);
> > > +		if (rc < 0) {
> > > +			dev_dbg(dev, "withhold DC extent DPA:0x%llx LEN:%llx\n",
> > > +									dpa, size);
> > > +			return 0;
> > > +		}
> > > +
> > > +		xa_erase(&mds->dc_extent_list, dpa);
> > > +		devm_kfree(dev, extent);
> > > +		mds->num_dc_extents--;
> > > +		rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &rel_range);
> > > +		if (rc < 0) {
> > > +			dev_err(dev, "Couldn't create extent list %d\n", rc);
> > > +			return rc;
> > > +		}
> > > +
> > > +		rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
> > > +					      CXL_MBOX_OP_RELEASE_DC);
> > > +		if (rc < 0)
> > > +			goto out;
> > > +
> > > +		break;
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +out:
> > 
> > The out seems needless. Replace all 'goto out''s  with 'break'
> > 
> > I'm also a bit concerned about all the direct returns above.
> > Can this be the single exit point?
> 
> I think so...
> 
> > kfree of a NULL ptr is OK.
> > Maybe a bit more logic here to do that devm_free is all that
> > is needed.
> 
> ... but even more clean up so that the logic is:
> 
> handle_event()
> {
> 
> 	... do checks ...
> 
> 	switch (type):
> 	case ADD...:
> 		rc = handle_add();
> 		break;
> 	case RELEASE...:
> 		rc = handle_release();
> 		break;
> 	default:
> 		rc = -EINVAL;
> 		break;
> 	}
> 
> 	return rc;
> }

Second it. 

Fan
> 
> > 
> > 
> > > +	kfree(dc_res);
> > > +	return rc;
> > > +}
> > > +
> > >  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > >  				    enum cxl_event_log_type type)
> > >  {
> > > @@ -982,9 +1180,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> > >  		if (!nr_rec)
> > >  			break;
> > >  
> > > -		for (i = 0; i < nr_rec; i++)
> > > +		for (i = 0; i < nr_rec; i++) {
> > >  			cxl_event_trace_record(cxlmd, type,
> > >  					       &payload->records[i]);
> > > +			if (type == CXL_EVENT_TYPE_DCD) {
> > > +				rc = cxl_handle_dcd_event_records(mds,
> > > +						&payload->records[i]);
> > > +				if (rc)
> > > +					dev_err_ratelimited(dev,
> > > +						"dcd event failed: %d\n", rc);
> > > +			}
> > 
> > 
> > Reduce indent option:
> > 
> > 			if (type != CXL_EVENT_TYPE_DCD)
> > 				continue;
> > 
> > 			rc = cxl_handle_dcd_event_records(mds,
> > 							  &payload->records[i]);			if (rc)
> > 				dev_err_ratelimited(dev,
> > 						    "dcd event failed: %d\n", rc);
> 
> Ah...  Ok.
> 
> Honestly I just made this change and I'm not keen on it.  I think it makes
> the detail that the event was DCD obscured.
> 
> I'm also questioning the need to the error reporting here.  There seems to
> be error messages in the critical parts of cxl_handle_dcd_event_records()
> which would give a clue as to why the DCD failed.  (Other than some common
> memory allocation issues.)  But also those errors are not rate limited.
> So if we are concerned with a FM or other external entity causing events
> which flood the logs it seems they all need to be debug or ratelimited.
> 
> > 
> > I don't know where 'cxl_handle_dcd_event_records() was introduce,
> > but I'm wondering now if it can have a short name.
> 
> Its the function above which needs all the rework.
> 
> > 
> > > +		}
> > >  
> > >  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > >  			trace_cxl_overflow(cxlmd, type, payload);
> > > @@ -1024,6 +1230,8 @@ void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
> > >  		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
> > >  	if (status & CXLDEV_EVENT_STATUS_INFO)
> > >  		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> > > +	if (status & CXLDEV_EVENT_STATUS_DCD)
> > > +		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> > >  
> > > @@ -1244,6 +1452,140 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> > >  
> > > +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> > > +			      unsigned int *extent_gen_num)
> > > +{
> > > +	struct device *dev = mds->cxlds.dev;
> > > +	struct cxl_mbox_dc_extents *dc_extents;
> > > +	struct cxl_mbox_get_dc_extent get_dc_extent;
> > > +	unsigned int total_extent_cnt;
> > 
> > Seems 'count' would probably suffice here.
> 
> Done.
> 
> > 
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	int rc;
> > 
> > Above - reverse x-tree please.
> 
> Done.
> 
> > 
> > > +
> > > +	/* Check GET_DC_EXTENT_LIST is supported by device */
> > > +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> > > +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> > > +		return 0;
> > > +	}
> > > +
> > > +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
> > > +	if (!dc_extents)
> > > +		return -ENOMEM;
> > > +
> > > +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> > > +		.extent_cnt = 0,
> > > +		.start_extent_index = 0,
> > > +	};
> > > +
> > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > > +		.payload_in = &get_dc_extent,
> > > +		.size_in = sizeof(get_dc_extent),
> > > +		.size_out = mds->payload_size,
> > > +		.payload_out = dc_extents,
> > > +		.min_out = 1,
> > > +	};
> > > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > > +	if (rc < 0)
> > > +		goto out;
> > > +
> > > +	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> > > +	*extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
> > > +	dev_dbg(dev, "Total extent count :%d Extent list Generation Num: %d\n",
> > > +			total_extent_cnt, *extent_gen_num);
> > > +out:
> > > +
> > > +	kvfree(dc_extents);
> > > +	if (rc < 0)
> > > +		return rc;
> > > +
> > > +	return total_extent_cnt;
> > > +
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extent_cnt, CXL);
> > > +
> > > +int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
> > > +			   unsigned int index, unsigned int cnt)
> > > +{
> > > +	/* See CXL 3.0 Table 125 dynamic capacity config  Output Payload */
> > > +	struct device *dev = mds->cxlds.dev;
> > > +	struct cxl_mbox_dc_extents *dc_extents;
> > > +	struct cxl_mbox_get_dc_extent get_dc_extent;
> > > +	unsigned int extent_gen_num, available_extents, total_extent_cnt;
> > > +	int rc;
> > > +	struct cxl_dc_extent_data *extent;
> > > +	struct cxl_mbox_cmd mbox_cmd;
> > > +	struct range alloc_range;
> > > +
> > 
> > Reverse x-tree please.
> 
> Done.
> 
> > 
> > > +	/* Check GET_DC_EXTENT_LIST is supported by device */
> > > +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> > > +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> > > +		return 0;
> > > +	}
> > 
> > Can we even get this far if this cmd is not supported by the device?
> > Is there a sooner place to test those bits?  Is this sysfs request?
> > (sorry not completely following here).
> > 
> 
> I'll have to check.  Perhaps Navneet knows.
> 
> > > +
> > > +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
> > > +	if (!dc_extents)
> > > +		return -ENOMEM;
> > > +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> > > +		.extent_cnt = cnt,
> > > +		.start_extent_index = index,
> > > +	};
> > > +
> > > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > > +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > > +		.payload_in = &get_dc_extent,
> > > +		.size_in = sizeof(get_dc_extent),
> > > +		.size_out = mds->payload_size,
> > > +		.payload_out = dc_extents,
> > > +		.min_out = 1,
> > > +	};
> > > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > > +	if (rc < 0)
> > > +		goto out;
> > > +
> > > +	available_extents = le32_to_cpu(dc_extents->ret_extent_cnt);
> > > +	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> > > +	extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
> > > +	dev_dbg(dev, "No Total extent count :%d Extent list Generation Num:%d\n",
> > > +			total_extent_cnt, extent_gen_num);
> > > +
> > > +
> > > +	for (int i = 0; i < available_extents ; i++) {
> > > +		extent = devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL);
> > > +		if (!extent) {
> > > +			rc = -ENOMEM;
> > > +			goto out;
> > > +		}
> > > +		extent->dpa_start = le64_to_cpu(dc_extents->extent[i].start_dpa);
> > > +		extent->length = le64_to_cpu(dc_extents->extent[i].length);
> > > +		memcpy(extent->tag, dc_extents->extent[i].tag,
> > > +					sizeof(dc_extents->extent[i].tag));
> > > +		extent->shared_extent_seq =
> > > +				le16_to_cpu(dc_extents->extent[i].shared_extn_seq);
> > > +		dev_dbg(dev, "dynamic capacity extent[%d] DPA:0x%llx LEN:%llx\n",
> > > +				i, extent->dpa_start, extent->length);
> > > +
> > > +		alloc_range = (struct range){
> > > +			.start = extent->dpa_start,
> > > +			.end = extent->dpa_start + extent->length - 1,
> > > +		};
> > > +
> > > +		rc = cxl_add_dc_extent(mds, &alloc_range);
> > > +		if (rc < 0)
> > > +			goto out;
> > > +		rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
> > > +				GFP_KERNEL);
> > > +	}
> > > +
> > > +out:
> > > +	kvfree(dc_extents);
> > > +	if (rc < 0)
> > > +		return rc;
> > > +
> > > +	return available_extents;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extents, CXL);
> > > +
> > >  static int add_dpa_res(struct device *dev, struct resource *parent,
> > >  		       struct resource *res, resource_size_t start,
> > >  		       resource_size_t size, const char *type)
> > > @@ -1452,6 +1794,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> > >  	mutex_init(&mds->event.log_lock);
> > >  	mds->cxlds.dev = dev;
> > >  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> > > +	xa_init(&mds->dc_extent_list);
> > >  
> > >  	return mds;
> > >  }
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 144232c8305e..ba45c1c3b0a9 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1,6 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> > >  #include <linux/memregion.h>
> > > +#include <linux/interrupt.h>
> > >  #include <linux/genalloc.h>
> > >  #include <linux/device.h>
> > >  #include <linux/module.h>
> > > @@ -11,6 +12,8 @@
> > >  #include <cxlmem.h>
> > >  #include <cxl.h>
> > >  #include "core.h"
> > > +#include "../../dax/bus.h"
> > > +#include "../../dax/dax-private.h"
> > >  
> > >  /**
> > >   * DOC: cxl core region
> > > @@ -166,6 +169,38 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> > >  	return 0;
> > >  }
> > >  
> > > +static int cxl_region_manage_dc(struct cxl_region *cxlr)
> > > +{
> > > +	struct cxl_region_params *p = &cxlr->params;
> > > +	unsigned int extent_gen_num;
> > > +	int i, rc;
> > > +
> > > +	/* Designed for Non Interleaving flow with the assumption one
> > > +	 * cxl_region will map the complete device DC region's DPA range
> > > +	 */
> > > +	for (i = 0; i < p->nr_targets; i++) {
> > > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > > +		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > > +
> > > +		rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> > > +		if (rc < 0)
> > > +			goto err;
> > > +		else if (rc > 1) {
> > > +			rc = cxl_dev_get_dc_extents(mds, rc, 0);
> > > +			if (rc < 0)
> > > +				goto err;
> > > +			mds->num_dc_extents = rc;
> > > +			mds->dc_extents_index = rc - 1;
> > > +		}
> > 
> > Brackets required around both arms of that if/else if statement. 
> > (checkpatch should be telling you that)
> > 
> > How about flipping that and doing the (rc > 1) work first.
> > then the else if, goto err.
> 
> Actually the goto err handles it all.  Just get rid of the 'else'
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 57f8ec9ef07a..47f94dec47f4 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -186,7 +186,8 @@ static int cxl_region_manage_dc(struct cxl_region *cxlr)
>                 rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
>                 if (rc < 0)
>                         goto err;
> -               else if (rc > 1) {
> +
> +               if (rc > 1) {
>                         rc = cxl_dev_get_dc_extents(mds, rc, 0);
>                         if (rc < 0)
>                                 goto err;
> 
> > 
> > > +		mds->dc_list_gen_num = extent_gen_num;
> > > +		dev_dbg(mds->cxlds.dev, "No of preallocated extents :%d\n", rc);
> > > +	}
> > > +	return 0;
> > > +err:
> > > +	return rc;
> > > +}
> > > +
> > >  static int commit_decoder(struct cxl_decoder *cxld)
> > >  {
> > >  	struct cxl_switch_decoder *cxlsd = NULL;
> > > @@ -2865,11 +2900,14 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> > >  		return PTR_ERR(cxlr_dax);
> > >  
> > >  	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
> > > -	if (!cxlr_dc) {
> > > -		rc = -ENOMEM;
> > > -		goto err;
> > > -	}
> > > +	if (!cxlr_dc)
> > > +		return -ENOMEM;
> > >  
> > > +	rc = request_module("dax_cxl");
> > > +	if (rc) {
> > > +		dev_err(dev, "failed to load dax-ctl module\n");
> > > +		goto load_err;
> > > +	}
> > >  	dev = &cxlr_dax->dev;
> > >  	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> > >  	if (rc)
> > > @@ -2891,10 +2929,24 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> > >  	xa_init(&cxlr_dc->dax_dev_list);
> > >  	cxlr->cxlr_dc = cxlr_dc;
> > >  	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
> > > -	if (!rc)
> > > -		return 0;
> > > +	if (rc)
> > > +		goto err;
> > > +
> > > +	if (!dev->driver) {
> > > +		dev_err(dev, "%s Driver not attached\n", dev_name(dev));
> > > +		rc = -ENXIO;
> > > +		goto err;
> > > +	}
> > > +
> > > +	rc = cxl_region_manage_dc(cxlr);
> > > +	if (rc)
> > > +		goto err;
> > > +
> > > +	return 0;
> > > +
> > >  err:
> > >  	put_device(dev);
> > > +load_err:
> > >  	kfree(cxlr_dc);
> > >  	return rc;
> > >  }
> > > @@ -3076,6 +3128,156 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
> > >  
> > > +static int match_ep_decoder_by_range(struct device *dev, void *data)
> > > +{
> > > +	struct cxl_endpoint_decoder *cxled;
> > > +	struct range *dpa_range = data;
> > > +
> > > +	if (!is_endpoint_decoder(dev))
> > > +		return 0;
> > > +
> > > +	cxled = to_cxl_endpoint_decoder(dev);
> > > +	if (!cxled->cxld.region)
> > > +		return 0;
> > > +
> > > +	if (cxled->dpa_res->start <= dpa_range->start &&
> > > +				cxled->dpa_res->end >= dpa_range->end)
> > > +		return 1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int cxl_release_dc_extent(struct cxl_memdev_state *mds,
> > > +			  struct range *rel_range)
> > > +{
> > > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > > +	struct cxl_endpoint_decoder *cxled;
> > > +	struct cxl_dc_region *cxlr_dc;
> > > +	struct dax_region *dax_region;
> > > +	resource_size_t dpa_offset;
> > > +	struct cxl_region *cxlr;
> > > +	struct range hpa_range;
> > > +	struct dev_dax *dev_dax;
> > > +	resource_size_t hpa;
> > > +	struct device *dev;
> > > +	int ranges, rc = 0;
> > > +
> > > +	/*
> > > +	 * Find the cxl endpoind decoder with which has the extent dpa range and
> > > +	 * get the cxl_region, dax_region refrences.
> > > +	 */
> > > +	dev = device_find_child(&cxlmd->endpoint->dev, rel_range,
> > > +				match_ep_decoder_by_range);
> > > +	if (!dev) {
> > > +		dev_err(mds->cxlds.dev, "%pr not mapped\n", rel_range);
> > > +		return PTR_ERR(dev);
> > > +	}
> > > +
> > > +	cxled = to_cxl_endpoint_decoder(dev);
> > > +	hpa_range = cxled->cxld.hpa_range;
> > > +	cxlr = cxled->cxld.region;
> > > +	cxlr_dc = cxlr->cxlr_dc;
> > > +
> > > +	/* DPA to HPA translation */
> > > +	if (cxled->cxld.interleave_ways == 1) {
> > > +		dpa_offset = rel_range->start - cxled->dpa_res->start;
> > > +		hpa = hpa_range.start + dpa_offset;
> > > +	} else {
> > > +		dev_err(mds->cxlds.dev, "Interleaving DC not supported\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	dev_dax = xa_load(&cxlr_dc->dax_dev_list, hpa);
> > > +	if (!dev_dax)
> > > +		return -EINVAL;
> > > +
> > > +	dax_region = dev_dax->region;
> > > +	ranges = dev_dax->nr_range;
> > > +
> > > +	while (ranges) {
> > > +		int i = ranges - 1;
> > > +		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
> > > +
> > > +		devm_release_action(dax_region->dev, unregister_dax_mapping,
> > > +								&mapping->dev);
> > > +		ranges--;
> > > +	}
> > > +
> > > +	dev_dbg(mds->cxlds.dev, "removing devdax device:%s\n",
> > > +						dev_name(&dev_dax->dev));
> > > +	devm_release_action(dax_region->dev, unregister_dev_dax,
> > > +							&dev_dax->dev);
> > > +	xa_erase(&cxlr_dc->dax_dev_list, hpa);
> > > +
> > > +	return rc;
> > > +}
> > > +
> > > +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range)
> > > +{
> > > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > > +	struct cxl_endpoint_decoder *cxled;
> > > +	struct cxl_dax_region *cxlr_dax;
> > > +	struct cxl_dc_region *cxlr_dc;
> > > +	struct dax_region *dax_region;
> > > +	resource_size_t dpa_offset;
> > > +	struct dev_dax_data data;
> > > +	struct dev_dax *dev_dax;
> > > +	struct cxl_region *cxlr;
> > > +	struct range hpa_range;
> > > +	resource_size_t hpa;
> > > +	struct device *dev;
> > > +	int rc;
> > > +
> > > +	/*
> > > +	 * Find the cxl endpoind decoder with which has the extent dpa range and
> > > +	 * get the cxl_region, dax_region refrences.
> > > +	 */
> > > +	dev = device_find_child(&cxlmd->endpoint->dev, alloc_range,
> > > +				match_ep_decoder_by_range);
> > > +	if (!dev) {
> > > +		dev_err(mds->cxlds.dev, "%pr not mapped\n",	alloc_range);
> > > +		return PTR_ERR(dev);
> > > +	}
> > > +
> > > +	cxled = to_cxl_endpoint_decoder(dev);
> > > +	hpa_range = cxled->cxld.hpa_range;
> > > +	cxlr = cxled->cxld.region;
> > > +	cxlr_dc = cxlr->cxlr_dc;
> > > +	cxlr_dax = cxlr_dc->cxlr_dax;
> > > +	dax_region = dev_get_drvdata(&cxlr_dax->dev);
> > > +
> > > +	/* DPA to HPA translation */
> > > +	if (cxled->cxld.interleave_ways == 1) {
> > > +		dpa_offset = alloc_range->start - cxled->dpa_res->start;
> > > +		hpa = hpa_range.start + dpa_offset;
> > > +	} else {
> > > +		dev_err(mds->cxlds.dev, "Interleaving DC not supported\n");
> > > +		return -EINVAL;
> > > +	}
> > 
> > Hey, I'm running out of steam here,
> 
> :-D
> 
> > but lastly between these last
> > 2 funcs, seems some duplicate code. Is there maybe an opportunity
> > for a common func that can 'add' or 'release' a dc extent?
> 
> Maybe.  I'm too tired to see how this intertwines with
> cxl_handle_dcd_event_records() and cxl_dev_get_dc_extents().  But the returning
> of the range is odd.  Might be ok I think.  But perhaps
> cxl_handle_dcd_event_records() and cxl_dev_get_dc_extents() can issue the
> device_find_child() or something?
> 
> > 
> > 
> > 
> > The end.
> 
> Thanks for looking!
> Ira

-- 
Fan Ni <nifan@outlook.com>
