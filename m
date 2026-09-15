Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB74BB27F
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494135; cv=none; b=QRL18cPOhTx7uu2C0l0R9DkcS3ar3Gb3yFoPtizu5K3JTpa9+VDtY+gmXa2yPkqs/rBN26vLgxgcdQ0x8iDzSPz5k4QWWXxw92HcTv7c7Xr9In2emBQ+KXeGvCSiAdJFcqxipuS8EpPSgbaUQQfIT5fRLw4kP/QtPhdW42fZCG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494135; c=relaxed/simple;
	bh=ArgVqEJVNn8PDfV/PVviRF57YBVOqluQWqgneZG7+IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYulqPH4/kUF8+/mKTVxXWladtRVjVN/t4nbLbCWoLF2dIp65P8exGsikYmpVq7KRZOf8m1QaZ1o38YrTDZwnhM8vDgwWmxy5LYTNWnLsojUr4hhKa+sFxVsfN91ai0Ssd+wPzTVKDsnNfrGTCus2+j/PMDHQld+DBGq5j8shDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7UYsLSD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7UYsLSD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70621F000FF;
	Tue, 15 Sep 2026 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789494132;
	bh=1AThVhaGeh4/PJ05r5sSt3mgE4UqxOGfJ9KavZCZd/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h7UYsLSDX/7CbrxPhBtoDfbdbGOSAGhcEu6okfZXeU3IOgDZMqCVEsEgf/62sAiFg
	 R+QDQHo7trhbSxuIY+irX+KSLfDQM8Pgs7IVKat2yH4otYZzbzrCfblYngUbnvGxjs
	 3eHhjGDplU8Ellbrjn2+oFa4wFO0ub4AzwHtHS+ce9fPvjZT+4xdV5uw77rqbyrguN
	 MKN2GZD4vb++oOraSlkuFHGyUn/xH1oEriPdFxpJuhdHav5WMKIA32M+Z9QtWkMNiH
	 ff5oKS/9pnsHYhvLeoiUXEJ+o7S5Bqmx2tFr3mDlZjl6X0smH7ESoJkUztQqu8hutJ
	 dg1CwNIwl9RKQ==
Date: Tue, 15 Sep 2026 18:42:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Kevin Wolf
 <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Lukas Straub <lukasstraub2@web.de>, Eric Blake
 <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, linux-cxl@vger.kernel.org, Zhao Liu
 <zhao1.liu@intel.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/7] qapi: convert remaining simple intros for
 cxl.json
Message-ID: <20260915184206.0c7a608f@jic23-hlaptop>
In-Reply-To: <20260915151127.1002244-3-jsnow@redhat.com>
References: <20260915151127.1002244-1-jsnow@redhat.com>
	<20260915151127.1002244-3-jsnow@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 11:11:22 -0400
John Snow <jsnow@redhat.com> wrote:

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks
