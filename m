Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792463693;
	b=C0BzCVnqX4rZlwDJw7QIBi6lPELLWkJ/9CtBRzaZIZJLVR5iG3W3hKMucvLuh4daOuTS
	 B2kos38RNSsBPJFwgSy8vP3cbNOWrqh8DTRDJ8cN2EwmQ0zNE/eTh4Tdsv+abssDTJg/f
	 0ryn7PvSsQMXOl7hWg9SJyfKAR6HTDHO3SfsZT0Asi0fWjUzyY1CMcX7upMlJ9sqwtk4H
	 E0id9/j0Fq4SiSvpH5K1ksLxlADhsfbcOTN+XbU2DHbxUug9/EU0na8CSIu1AX61B1mjh
	 IUMWJVgUk2ItX342pV11L7riqbGbyR3ZyK4SaMgySsWGyyA4RnNuVoHFz88H6bhM+gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792463693;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=3psP1VwAmHfiXNeg/RcdyEOIUAjAmF1YmK/0fkI5OTY=;
	b=zzUl2ZLSqSRwbpVYKzO8ClmjkJ/lcPDyD/qTDk1kAEjA7rrkSfWI46xUKK/mwJyfvdNz
	 5T42aqJK85m4TnA6NK5IF5nE5pN11RfvafG4RAtUxiBLzKbGv8vpAPm192atbqKdTnkSr
	 /scw9mj54agQJY9UHvknb/y0OCsAPYPXCn7k/uMzGT5yW6wEGh8oEn4kwY85w25BCbuSF
	 OFOixAndOVUCr7Dd9D7S9A8apBgUNY36qIlB0XGquCXEUU6voWdXJdMr/w+l4v3IXALSC
	 o4wWZn6o9qAqOpjUmylyleGdLJlYC9EeRRqlznGzvX/TDlTzlUuUJflJKjUSEqbEz6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=HIBFpTzX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C330D606A319
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 02:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C330D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=ming.li@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=HIBFpTzX
ARC-Seal: i=1; a=rsa-sha256; t=1792463686; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nOIeHQnGSekV4cOQTtcjAPbh0xIfDOmhrjHQBIai6RzwhvA2tsKAryWa1OQxcxM4gBoehP2/YQlDreE3qfz1iIF28/ihTkniBWer3mPrAbXBl8oS5W1cRf5M7qm8dO127sjI81yUqGad2o5LqLzkiqnMrd0PtvFb7gWGv3zA8tQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792463686; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3psP1VwAmHfiXNeg/RcdyEOIUAjAmF1YmK/0fkI5OTY=; 
	b=j924e9m82SrYfjWtjE4KCOzVj+KqHrJ9+KJelU9rsvF4qIB4mLKkDHX+fVjAmv6v7ayRFk5fDFwRVsU+MIYynAgyUCZpNRIxYvvvuU2CiTv6Ws2p1yPFVV8I8RZvBBB23Y1FISi3JyUiQJ72GkOBuUyutDV2RgTAbD6QRIwbxGw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792463686;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=3psP1VwAmHfiXNeg/RcdyEOIUAjAmF1YmK/0fkI5OTY=;
	b=HIBFpTzX1aIpuOpvsNu/b8l41JkkxsuD5antKt7/EcwYHbawi8Kelwm0rHnRnkGb
	UBsJPiMGhp0Ifk3vdS/xSJ3srLwA2GYDQhMmkTPyNXdBypY/kkNj3QtvrgcO980+9ut
	VsyO7RYSS2FH5krJFwQsrjjXptiZB7YsKeLu+EDg=
Received: by smtp.zohomail.com with SMTPS id 1792463684693796.3815344482545;
	Mon, 19 Oct 2026 19:34:44 -0700 (PDT)
Message-ID: <0a9ae8ff-3d37-4305-814e-d1dd2759865d@zohomail.com>
Date: Tue, 20 Oct 2026 10:34:40 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org
References: <cover.1791949910.git.alison.schofield@intel.com>
 <ccb2c0974781ec3500c56e82c61eb3026c73d183.1791949910.git.alison.schofield@intel.com>
 <4e79ef12-5873-43ef-a763-47fb062dc77a@zohomail.com>
 <ataJ_b397PDR6YwP@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ataJ_b397PDR6YwP@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227516da26248fabfa37d210f090000dc97e2604a53f5a762d53bd0562e6e8a90d0df2bed21b4bde5:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/10/20 05:22, Alison Schofield 写道:
> On Thu, Oct 15, 2026 at 05:37:26PM +0800, Li Ming wrote:
>> 在 2026/10/14 12:17, Alison Schofield 写道:
>>> cxl_internal_send_cmd() validates mailbox payload sizes, translates device
>>> return codes to errnos, and checks returned output sizes. Existing cxl_test
>>> coverage does not exercise many of its error paths.
>>>
>>> Add a KUnit suite that replaces mbox_send() with a stub transport, allowing
>>> tests to control transport errors, device return codes, and output sizes.
>>>
>>> The suite covers command forwarding, payload size limits, transport errors,
>>> defined and unknown device return codes, background commands, and fixed
>>> versus variable output sizes.
>>>
>>> The unknown return code cases provide regression coverage for "cxl/mbox:
>>> Treat unknown device return codes as errors". Without that change, the
>>> tests fail and KASAN reports a global out-of-bounds read.
>>>
>>> The suite uses the existing CONFIG_CXL_KUNIT_TEST option, allowing it to
>>> run without additional configuration.
>>>
>>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>>> ---
>>>    Documentation/driver-api/cxl/testing.rst |   3 +
>>>    drivers/cxl/core/Makefile                |   1 +
>>>    drivers/cxl/core/tests/Makefile          |   5 +
>>>    drivers/cxl/core/tests/mbox_kunit.c      | 249 +++++++++++++++++++++++
>>>    4 files changed, 258 insertions(+)
>>>    create mode 100644 drivers/cxl/core/tests/Makefile
>>>    create mode 100644 drivers/cxl/core/tests/mbox_kunit.c
>>>
> snip
>
>
>>> +static int cxl_mbox_test_init(struct kunit *test)
>>> +{
>>> +	struct mock_mbox *mock;
>>> +
>>> +	mock = kunit_kzalloc(test, sizeof(*mock), GFP_KERNEL);
>>> +	KUNIT_ASSERT_NOT_NULL(test, mock);
>>> +
>>> +	mock->cxl_mbox.payload_size = TEST_PAYLOAD_SIZE;
>>> +	mock->cxl_mbox.mbox_send = mock_mbox_send;
> 	mock->return_code = CXL_MBOX_CMD_RC_SUCCESS;
>
>
>>> +	test->priv = mock;
>> How about adding a line "mock->return_code = CXL_MBOX_CMD_RC_SUCCESS" here
>> to explicitly initialize mock->return_code? It makes easier for readers to
>> see the default return_code is SUCCESS.
>>
> Thanks and agree. Done like above in v2.
>
>
> snip more below...
>>> +
>>> +static void send_unknown_return_code(struct kunit *test)
>>> +{
>>> +	static const u16 codes[] = { ARRAY_SIZE(cxl_mbox_cmd_rctable), 0x100,
>>> +				     0xffff };
>>> +	struct mock_mbox *mock = test->priv;
>>> +
>>> +	/* Codes the driver does not know are still device errors */
>>> +	for (int i = 0; i < ARRAY_SIZE(codes); i++) {
>>> +		struct cxl_mbox_cmd cmd = {};
>>> +		int rc;
>>> +
>>> +		mock->return_code = codes[i];
>>> +		rc = cxl_internal_send_cmd(&mock->cxl_mbox, &cmd);
>>> +		KUNIT_EXPECT_EQ_MSG(test, rc, -ENXIO, "return_code=%#x",
>>> +				    codes[i]);
>>> +		KUNIT_EXPECT_STREQ_MSG(test, cxl_mbox_cmd_rc2str(&cmd),
>>> +				       "unknown return code", "return_code=%#x",
>>> +				       codes[i]);
>>> +	}
>>> +}
>> Since we already have cxl_mbox_cmd_rctable here, should we also cover the
>> existing return_codes that we know?
>
> The known return codes are covered by send_device_error(). That iterates
> thru the rc table and checks the expected errno for each entry. SUCCESS
> and BACKGROUND are covered by their own tests.
>
> The unknown return code test exercises the new out-of-range handling, so
> I think we have the coverage we need here.

Yes, you are right, I missed this part, sorry for that.


Ming

>
> -- Alison
